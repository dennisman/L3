package ex4_got;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Personnage roi = new Roi();
		Personnage rei = new Reine();
		Personnage mar = new MarcheurBlanc();
		
		
		roi.combattre();
		rei.combattre();
		mar.combattre();
		
		rei.setArme(new ComportementHache());
		rei.combattre();
		
		

	}

}
