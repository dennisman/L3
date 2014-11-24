package Ex1GogoleCar;

public class EtatAttente extends Etat {
	public EtatAttente(GoogleCar c) {
		super(c);
		
	}

	public void push () {
		car.setEtat(car.getEtatArrete());
		System.out.println("J'arrete le Moteur");
	}
	public void entrezAdresse()
	{
		car.setEtat(car.getEtatConduite());
		System.out.println("allons a cette adresse");
	}

}
