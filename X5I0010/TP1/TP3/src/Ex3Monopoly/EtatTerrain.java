package Ex3Monopoly;

public abstract class EtatTerrain {
	private Propriete terrain;

	public EtatTerrain(Propriete p) {
		terrain = p;
	}

	public void Sell (int prix) {
		System.out.println("deja vendu");
	}

	public void Buy () {
		System.out.println("deja posseder");
	}
	public void droits(int prix) {
		System.out.println("je paye " + prix);
	}


}
