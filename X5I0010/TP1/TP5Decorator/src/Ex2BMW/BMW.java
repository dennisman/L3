package Ex2BMW;

public abstract class BMW {
	private String carbu;
	private int prix;
	
	public BMW(){}
	public BMW(String carbu_, int p) {
		prix = p;
		carbu=carbu_;
	}

	
	public int getPrix(){
		return prix;

	}
	
	public String getCarbu(){
		return carbu;
	}
	
	public int cout(){
		return prix;
	}
}

