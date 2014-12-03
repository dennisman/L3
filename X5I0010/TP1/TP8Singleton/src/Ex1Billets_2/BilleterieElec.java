package Ex1Billets_2;

public class BilleterieElec implements Billeterie {
	private int numero;
	public BilleterieElec() {
		numero = 0;
	}

	@Override
	public Billet factoryMethod() {
		++numero;
		return new BIlletElec(numero);
	}

}
