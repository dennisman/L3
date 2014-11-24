package Ex3Monopoly;

public class EtatNoProp extends EtatTerrain {

	public EtatNoProp(Propriete p) {
		super(p);
		// TODO Auto-generated constructor stub
	}
	
	public void Buy(){
		System.out.println("acheté !");
		terrain.setEtat(terrain.getEtatPossess()));
	}
	public void droits(int prix){
		System.out.println("pas de prop, pas de loyer");
	}

}
