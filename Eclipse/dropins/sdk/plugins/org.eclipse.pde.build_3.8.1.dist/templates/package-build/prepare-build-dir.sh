#!/bin/sh

if [ $# -lt 2 ]; then
  echo "usage: $0 <path to source dir> <path to build dir>"
  exit 1
fi

if [ ! -d $1 ]; then
  echo "usage: $0 <path to source dir> <path to build dir>"
  exit 1
fi

SOURCEDIR=$1
BUILDDIR=$2
TESTING=$3

echo "preparing files in $1 for buildfile generation ..."
mkdir -p $BUILDDIR

# make some ant build files to extract the id from the feature.xml, plugin.xml or the fragment.xml
mkdir -p $BUILDDIR/tmp
BUILDFILE=$BUILDDIR/tmp/build.xml

echo "<project default=\"main\">
	<target name=\"main\">
               	<xmlproperty file=\"@type@.xml\" collapseAttributes=\"true\"/>
		<fail unless=\"@type@.id\" message=\"feature.id not set\"/>
               	<echo message=\"\${@type@.id}\" />
        </target>
</project>" > $BUILDFILE

for type in feature plugin fragment; do
  CURBUILDFILE=$BUILDDIR/tmp/$type-build.xml
  cat $BUILDFILE | sed "s|@type@|$type|" > $CURBUILDFILE
done

# make the directories eclipse is expecting
echo "  making the 'features' and 'plugins' directories"
mkdir -p $BUILDDIR/features $BUILDDIR/plugins

# make symlinks for the features
FEATURES=$(find $SOURCEDIR -name feature.xml)
find $SOURCEDIR -name feature.xml | while read f; do
  PROJECTDIR=$(dirname "$f")
  inSDK=1
  inSDK=$(echo $PROJECTDIR | grep -c $BUILDDIR)
  if [ $inSDK = 0 ]; then
    PROJECTNAME=$(ant -Dbasedir="$PROJECTDIR" -f $BUILDDIR/tmp/feature-build.xml 2>&1 | grep echo | cut --delimiter=' ' -f 7)
    ERROR=""
    if [ -z "$PROJECTNAME" ]; then
      echo "ERROR: could not determine the feature id for $PROJECTDIR"
      if [ $TESTING != true ]; then
        exit 1
      else
        ERROR="yes"
      fi
    fi

    if [ "x$ERROR" != "xyes" ]; then
      if [ $TESTING != true ] || `echo "$PROJECTNAME" | grep "org.eclipse"`; then
        echo "  making symlink: $BUILDDIR/features/$PROJECTNAME -> $PROJECTDIR"
        ln -sfT "$PROJECTDIR" $BUILDDIR/features/"$PROJECTNAME"
      fi
    fi
  fi
done

# make symlinks for plugins and fragments
PLUGINDIRS=$(find $SOURCEDIR -name plugin.xml -o -name fragment.xml -o -name MANIFEST.MF | sed "s/plugin.xml//g" | sed "s/fragment.xml//g" | sed "s/META-INF\/MANIFEST.MF//" | sort | uniq)
find $SOURCEDIR -name plugin.xml -o -name fragment.xml -o -name MANIFEST.MF | sed "s/plugin.xml//g" | sed "s/fragment.xml//g" | sed "s/META-INF\/MANIFEST.MF//" | sort | uniq | while read dir; do
  PROJECTNAME=""
  ERROR=""
  inSDK=1
  inSDK=$(echo $dir | grep -c $BUILDDIR)
  if [ $inSDK = 0 ]; then
    if [ -e "$dir/META-INF/MANIFEST.MF" ]; then
      PROJECTNAME=$(grep Bundle-SymbolicName $dir/META-INF/MANIFEST.MF | cut --delimiter=';' -f 1 | cut --delimiter=' ' -f 2)
    elif [ -e "$dir/plugin.xml" ]; then
      PROJECTNAME=$(ant -Dbasedir=$dir -f $BUILDDIR/tmp/plugin-build.xml 2>&1 | grep echo | cut --delimiter=' ' -f 7)
    elif [ -e "$dir/fragment.xml" ]; then
      PROJECTNAME=$(ant -Dbasedir=$dir -f $BUILDDIR/tmp/fragment-build.xml 2>&1 | grep echo | cut --delimiter=' ' -f 7)
    fi

    if [ -z "$PROJECTNAME"  ]; then
      echo "ERROR: could not determine the plugin or fragment id for $dir"
      if [ $TESTING != true ]; then
        exit 1
      else
        ERROR="yes"
      fi
    fi

    if [ "x$ERROR" != "xyes" ]; then
      if [ $TESTING != true ] || `echo "$PROJECTNAME" | grep "org.eclipse"`; then
        echo "  making symlink: $BUILDDIR/plugins/$PROJECTNAME -> $dir"
        ln -sfT "$dir" $BUILDDIR/plugins/"$PROJECTNAME"
      fi
    fi;

  fi

done

rm -rf $BUILDDIR/tmp
echo done
