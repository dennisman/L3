open List
let longueur l=
  let
      liste = ref l
   and
      long = ref 0
  in
  while ! liste <> []
  do
    long := (! long) + 1 ;
    liste := tl (! liste)
  done ;
  ! long
;;

