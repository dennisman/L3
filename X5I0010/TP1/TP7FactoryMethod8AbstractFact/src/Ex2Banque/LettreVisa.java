package Ex2Banque;

public class LettreVisa extends Lettre {

	public LettreVisa(String a) {
		super(a);
	}
	
	public void ecrireLettre(){
		super.ecrireLettre();
		System.out.println("visa");
	}
}
