package Ex1int;

public class Hexa extends Decorator {

	public Hexa(Entier x) {
		super(x);

		
	}
	
	public void base(){
		ent.base();
		String res = Integer.toHexString(ent.getInt());
		System.out.println("hexa : "+ res);
	}

}
