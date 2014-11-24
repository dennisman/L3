package Ex2BilletPlane;

public class EtatAnnule extends Etat {

	public EtatAnnule(Billet b) {
		super(b);
		// TODO Auto-generated constructor stub
	}
	public void reserver()
	{
		System.out.println("réservé !");
		bif.setEtat(bif.getEtatReserve());
	}

}
