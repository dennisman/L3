package Ex3Monopoly;

public class EtatPossess extends EtatTerrain {
	private Joueur j;

	public EtatPossess(Propriete p) {
		super(p);
		// TODO Auto-generated constructor stub
	}
	public void Sell(int prix){
		System.out.println("vendu !");
		terrain.setEtat(terrain.getEtatLibre());
		j.win(prix);
	}

}
