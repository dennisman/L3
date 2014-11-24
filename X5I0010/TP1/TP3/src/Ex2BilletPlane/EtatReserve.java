package Ex2BilletPlane;

public class EtatReserve extends Etat {

	public EtatReserve(Billet b) {
		super(b);
		// TODO Auto-generated constructor stub
	}
	public void payer()
	{
		System.out.println("5€");
		System.out.println("transaction ...");
		bif.setEtat(bif.getEtatPaye());
	}

}
