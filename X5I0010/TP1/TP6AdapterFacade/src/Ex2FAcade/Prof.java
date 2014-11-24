package Ex2FAcade;

public class Prof {
	private Facade f;
	public Prof() {
		f = new Facade();
	}
	
	public void debutCours(){
		f.debutCours();
	}
	
	public void finCours(){
		f.finCours();
	}

}
