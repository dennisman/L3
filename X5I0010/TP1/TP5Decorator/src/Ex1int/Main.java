package Ex1int;

public class Main {

	public static void main(String[] args) {
		Entier entier = new Entier(17);
		//Decorator decoOcta1 = new Octa(entier); 
		
		entier = new Octa(entier); 	
		entier = new Binary(entier); 	
	
		entier = new Hexa(entier); 
		
		
		
		System.out.println("\n\n---------------------\n\n");
		entier.base();
		
		//decoOcta1.base();

	}

}
