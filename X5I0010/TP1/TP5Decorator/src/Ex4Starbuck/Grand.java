package Ex4Starbuck;



public class Grand extends Ex4Starbuck.Deco {

	public Grand(Boisson x) {
		super(x);
	}
	
	public double cout(){
		return b().cout()*1.25;
	}

}
