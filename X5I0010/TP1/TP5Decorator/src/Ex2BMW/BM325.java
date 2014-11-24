package Ex2BMW;

public class BM325 extends BMW {

	public BM325(String carbu_, int p) {
		super(carbu_, p);
	}
	
	public int cout(){
		return getPrix() + 1000;
	}

}
