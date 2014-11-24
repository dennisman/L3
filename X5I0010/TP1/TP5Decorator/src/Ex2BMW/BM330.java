package Ex2BMW;

public class BM330 extends BMW {

	public BM330(String carbu_, int p) {
		super(carbu_, p);
		// TODO Auto-generated constructor stub
	}

	public int cout(){
		return getPrix() + 3000;
	}

}
