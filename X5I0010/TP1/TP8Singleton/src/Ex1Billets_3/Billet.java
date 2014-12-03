package Ex1Billets_3;

public abstract class Billet {
	protected int numero;
	public Billet(int num) {
		numero =num;
	}
	
	public void aff(){
		System.out.println("billet " + numero + " " + getClass());
	}

}
