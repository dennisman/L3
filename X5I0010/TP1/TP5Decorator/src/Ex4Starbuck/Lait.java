package Ex4Starbuck;

public class Lait extends Deco {

	public Lait(Boisson b_) {
		super(b_);
	}

	
	public double cout(){
		return b().cout()+1;
	}
}
