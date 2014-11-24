package Ex2Banque;

public abstract class Lettre {
	protected String avantage;
	public Lettre(String a) {
		avantage = a;
	}
	
	public void ecrireLettre(){
		System.out.print("vous avez l'avantage  "+ avantage + "car vous avez choisi ");
	}

}
