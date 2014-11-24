package Ex1GogoleCar;

abstract class Etat {
	protected GoogleCar car;

	public Etat(GoogleCar c)
	{
		car = c;
	}

	public void push () {
		car.setEtat(car.getEtatAttente());
		System.out.println("j'attends, my moteur is ON");
	}
	public void entrezAdresse()
	{
		System.out.println("Pas le moment");
	}



}
