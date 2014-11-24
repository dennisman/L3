package Ex1BD_Chimie;

public class Molecule {
	private String name;
	private String formul;
	
	public Molecule(String n, String f) {
		name = n;
		formul = f;
	}
	
	public String affiche(){
		return name;
	}

}
