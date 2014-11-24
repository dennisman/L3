package Ex2BMW;

public class Metalisee extends Option {

	public Metalisee() {
		// TODO Auto-generated constructor stub
	}

	public Metalisee(BMW bmw) {
		super(bmw);
	}
	
	public int cout(){
		return getObj().cout() + 3;
	}

}
