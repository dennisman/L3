package InterGraph;

import java.awt.Color;

public abstract class Bouton {

	protected double larg;
	protected double haut;
	protected Color coul;

	public Bouton(double l, double h, Color c) {
		larg = l;
		haut = h;
		coul = c;
	}

}
