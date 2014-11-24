package Ex2BilletPlane;

public class EtatPaye extends Etat {

	public EtatPaye(Billet b) {
		super(b);
	}
	public void payer()
	{
		System.out.println("vous avez deja payé");
	}
	public void annuler()
	{
		System.out.println("vous ne pouvez que changer la date");
	}
	
	

}
