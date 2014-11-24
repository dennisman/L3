package Ex1int;

public class Entier {
	private String entier;  // on met private car les decorator n'ont pas besoin de dupliquer les attributs
	private int integ;
	
	public Entier(){}
	public Entier(int x) {
		entier = ""+ x;
		integ = x;
	}
	public Entier(Entier x){
		entier = x.entier;
		integ = x.integ;
	}
	
	public void base(){
		System.out.println("B10 entier : " + entier);
		
	}
	public String getString(){
		return entier;
	}
	public int getInt(){
		return integ;
	}

}
