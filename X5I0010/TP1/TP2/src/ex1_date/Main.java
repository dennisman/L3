package ex1_date;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		DatePerso today = new DatePerso();
		today.affichage();
		today.setAffichage(new AffichageUk());
		today.affichage();
		today.setAffichage(new AffichageUs());
		today.affichage();
		
	}

}
