package Ex2BilletPlane;






public class Billet {
	protected EtatPaye etatPaye;
	protected EtatAnnule etatAnnule;
	protected EtatReserve etatReserve;
	protected Etat etatCourant;
	protected String da;
	
	public Billet(String date) {
		etatPaye=new EtatPaye(this);
		etatAnnule=new EtatAnnule(this);
		etatReserve=new EtatReserve(this);
		etatCourant= etatAnnule;
		da = date;
	}
	
	public void setEtat(Etat state)
	{
		etatCourant= state;
	}
	
	public Etat getEtat()
	{
		return etatCourant;
	}
	public Etat getEtatPaye()
	{
		return etatPaye;
	}
	public Etat getEtatAnnule()
	{
		return etatAnnule;
	}
	public Etat getEtatReserve()
	{
		return etatReserve;
	}
	public void setDate(String d){
		da = d;
	}
	public void payer(){
		etatCourant.payer();
	}
	public void reserver(){
		etatCourant.reserver();
	}
	public void modifier(){
		etatCourant.modifier();
	}
	public void annuler(){
		etatCourant.annuler();
	}

}
