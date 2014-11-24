package Ex1GogoleCar;

public class GoogleCar {
	private EtatArrete etatArrete;
	private EtatConduite etatConduite;
	private EtatAttente etatAttente;
	private Etat etatCourant;

	public GoogleCar() {
		etatArrete=new EtatArrete(this);
		etatAttente=new EtatAttente(this);
		etatConduite=new EtatConduite(this);
		etatCourant= etatArrete;
	}

	public void push () {
		etatCourant.push();
	}
	public void entrerAdresse()
	{
		etatCourant.entrezAdresse();
	}
	public void setEtat(Etat state)
	{
		etatCourant= state;
	}
	
	public Etat getEtat()
	{
		return etatCourant;
	}
	public Etat getEtatConduite()
	{
		return etatConduite;
	}
	public Etat getEtatArrete()
	{
		return etatArrete;
	}
	public Etat getEtatAttente()
	{
		return etatAttente;
	}

}
