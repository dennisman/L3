package Ex1int;

public class Octa extends Decorator {

	public Octa(Entier x) {
		super(x);
		
	}
	
	public void base(){
		ent.base();
		String rese = Integer.toOctalString(ent.getInt());
		System.out.println("octa : "+ rese);
	}

}
