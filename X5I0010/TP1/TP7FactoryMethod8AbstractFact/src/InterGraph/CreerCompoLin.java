package InterGraph;

import java.awt.Color;

public class CreerCompoLin implements CreerCompo {

	public CreerCompoLin() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Bouton CreerBouton(double l, double h, Color c) {
		// TODO Auto-generated method stub
		return new BoutonLinux(l, h, c);
	}

	@Override
	public Menu CreerMenu() {
		// TODO Auto-generated method stub
		return new MenuLin();
	}

}
