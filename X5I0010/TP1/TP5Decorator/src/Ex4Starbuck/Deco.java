package Ex4Starbuck;

public abstract class Deco extends Boisson {
	private Boisson b;
	public Deco(Boisson b_) {
		b = b_;
	}
	
	public double cout(){
		return b.cout();
	}
	
	public Boisson b(){
		return b;
	}


}
