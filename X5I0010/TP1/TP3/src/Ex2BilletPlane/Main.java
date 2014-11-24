package Ex2BilletPlane;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Billet bif= new Billet("13/03/1993");
		bif.payer();
		bif.annuler();
		bif.modifier();
		bif.reserver();
		bif.annuler();
		bif.reserver();
		bif.payer();
		bif.annuler();
		bif.modifier();

	}

}
