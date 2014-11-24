package Ex4Starbuck;

public class Boisson {
	private String name;
	private double price;
	
	
	public Boisson() {
	}
	
	public Boisson(String nom, int prix) {
		price = prix;
		name = nom;
	}
	
	public double cout(){
		return price;
	}

}
