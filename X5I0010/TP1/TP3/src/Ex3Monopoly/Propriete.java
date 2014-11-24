package Ex3Monopoly;
import java.*;

import sun.net.www.content.audio.x_aiff;

public class Propriete {
	private EtatNoProp etatlibre;
	private EtatPossess etatpossede;
	private EtatTerrain etatcourant;
	private String nom;
	private int prix;
	private int droits;
	
	int x;
	
	public Propriete() {
		etatlibre = new EtatNoProp(this);
		etatpossede = new EtatPossess(this);
		etatcourant = etatlibre;
		//...
	}
	
	public void Sell(){ // appelé par sell dans la classe Joueur qui verifie si le Ji est le prop
		etatcourant.Sell(prix);
	}
	public void Buy(){ 
		etatcourant.Buy();
	}
	public void action(){
		etatcourant.droits(prix);
	}
	

}
