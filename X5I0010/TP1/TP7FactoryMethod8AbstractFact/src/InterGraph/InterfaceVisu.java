package InterGraph;

import java.awt.Color;

public class InterfaceVisu {
	private CreerCompo facto;
	private Bouton b;
	private Menu m;
	
	
	public InterfaceVisu(CreerCompo f) {
		facto = f;
		b = facto.CreerBouton(10, 10, new Color(5));
		m = facto.CreerMenu();
	}

}
