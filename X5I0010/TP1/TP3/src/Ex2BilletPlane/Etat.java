package Ex2BilletPlane;
import java.util.Scanner;

public abstract class Etat {

	protected Billet bif;
	
	public Etat(Billet b)
	{
		bif = b; 
	}
	
	public void payer()
	{
		System.out.println("veuillez reserver avant");
	}
	public void annuler()
	{
		bif.setEtat(bif.getEtatAnnule());
	}
	public void modifier()
	{
		Scanner scan_clav = new Scanner(System.in);
		String d;
		System.out.println("donnez la date");
		d = scan_clav.nextLine();
        scan_clav.nextLine();
		bif.setDate(d);
		
	}
	public void reserver(){
		System.out.println("deja reservé");
	}
	

}
