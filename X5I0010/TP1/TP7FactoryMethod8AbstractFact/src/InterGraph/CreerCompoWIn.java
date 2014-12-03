package InterGraph;

import java.awt.Color;

public class CreerCompoWIn implements CreerCompo {

	public CreerCompoWIn() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Bouton CreerBouton(double l, double h, Color c) {
		// TODO Auto-generated method stub
		return new BoutonWindows(l,h,c);
	}

	@Override
	public Menu CreerMenu() {
		// TODO Auto-generated method stub
		return new MenuWIn();
	}

}
