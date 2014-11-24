package Ex4Starbuck;

public class Caramel extends Deco {

	public Caramel(Boisson b_) {
		super(b_);
	}

	
	public double cout(){
		return b().cout()+3;
	}
}
