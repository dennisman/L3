class EtatNoProp extends EtatTerrain {

	public EtatNoProp() {
		
	}

}

abstract class EtatTerrain {
	private Propriete terrain;

	public EtatTerrain() {
		
	}

	public void Sell () {
		
	}

	public void Rent () {
		
	}

}

/*(NULL)*/
class Propriete {
	private EtatNoProp etatlibre;
	private EtatPossess etatpossede;
	private EtatTerrain etatcourant;
	private String nom;
	private int prix;
	private int droits;
	private Joueur proprio;

	public Propriete() {
		
	}

	public void action () {
		
	}

}

class EtatPossess extends EtatTerrain {

	public EtatPossess() {
		
	}

}

