/*(NULL)*/
abstract class Etat {
	private GoogleCar car;

	public Etat() {
		
	}

	public void Push () {
		
	}

}

/*(NULL)*/
class EtatAttente extends Etat {


}

/*(NULL)*/
class EtatArret extends Etat {

	public EtatArret() {
		
	}

	public void Push () {
		
	}

}

/*(NULL)*/
class GoogleCar {
	private EtatArret etatArret;
	private EtatConduite etatconduite;
	private EtatAttente etatAttente;
	private Etat etatcourant;

	public GoogleCar() {
		
	}

	public void action () {
		
	}

}

/*(NULL)*/


