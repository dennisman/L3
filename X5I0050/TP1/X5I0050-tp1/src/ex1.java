
public class ex1 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String livre_string;
		  String[] tab;
		  livre_string = "germinal.txt";
		  LecteurFichier lecteur = new LecteurFichier();
          if (lecteur.ouvrir(livre_string)) 
          {
        	String ligne, livre="";
        	while ((ligne = lecteur.lireLigne()) != null)
        	{
        		livre = livre + " " + ligne;
        	}
        	tab = livre.split(" ");
		    System.out.println(" nb de mots : ");
		    System.out.println( tab.length);
		    //System.out.println(livre);
          }
          else
          {
        	  System.out.println("error");
          }
		  
	}

}
