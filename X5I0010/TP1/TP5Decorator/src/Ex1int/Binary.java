package Ex1int;

public class Binary extends Decorator {

	public Binary(Entier x) {
		super(x);
	}
	
	public void base(){
		ent.base();
		String res = Integer.toBinaryString(ent.getInt());
		System.out.println("binaire : "+ res);
	}

}
