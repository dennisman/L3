package Ex2BMW;

public class Gps extends Option {

	public Gps() {
		// TODO Auto-generated constructor stub
	}

	public Gps(BMW bmw) {
		super(bmw);
		
	}
	
	public int cout(){
		return getObj().cout() + 5;
	}
}
