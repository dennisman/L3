package Ex1Horloge;

import java.util.*;

public abstract class Affichage {
	protected Horloge hor;
	protected String h;

	public Affichage(Horloge h) {
		hor = h;	
	}

	public void update () {
		h = hor.getClock();
		System.out.println("il est " + h);
	}
}
