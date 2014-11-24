package Ex2BMW;

public abstract class Option extends BMW {

	private BMW bm;
	
	public Option() {
		super();
	}

	public Option(BMW bmw){
		bm = bmw;
	}
	
	public int cout(){
		return bm.cout();
	}
	
	public BMW getObj(){
		return bm;
	}
}
