package Ex2Banque;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Factory f = new Factory();
		Lettre visa = f.factoryMethod("visa");
		Lettre master = f.factoryMethod("mastercad");
		Lettre american = f.factoryMethod("american");
		
		
		visa.ecrireLettre();
		master.ecrireLettre();
		american.ecrireLettre();

	}

}
