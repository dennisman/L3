package Ex4Starbuck;



public class Petit extends Ex4Starbuck.Deco {

	public Petit(Boisson x) {
		super(x);
	}
	
	public double cout(){
		return b().cout()*0.75;
	}

}
