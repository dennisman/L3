package Ex4Starbuck;

public class Main {


	public static void main(String[] args) {
		Boisson cafe = new Cafe();
		Boisson the = new Tea();
		
		System.out.println(cafe.cout());
		System.out.println(the.cout());
		System.out.println("------------------");
		
		cafe = new Lait(cafe);
		System.out.println(cafe.cout());
		System.out.println(the.cout());
		System.out.println("------------------");
		
		cafe= new Petit(cafe);
		System.out.println(cafe.cout());
		System.out.println(the.cout());
		System.out.println("------------------");
		
		cafe = new Caramel(cafe);
		System.out.println(cafe.cout());
		System.out.println(the.cout());
		System.out.println("------------------");

	}

}
