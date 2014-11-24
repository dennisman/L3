package Ex1Horloge;

public class Analogique extends Affichage {

	public Analogique(Horloge h) {
		super(h);
	}
	
	
	public void update () {
		
		System.out.println("affichage Analogique : ");
		super.update();
		
	}
}
