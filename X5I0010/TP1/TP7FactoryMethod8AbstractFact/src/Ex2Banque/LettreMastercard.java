package Ex2Banque;

public class LettreMastercard extends Lettre {

	public LettreMastercard(String a) {
		super(a);
	}

	public void ecrireLettre(){
		super.ecrireLettre();
		System.out.println("Mastercard");
	}
}
