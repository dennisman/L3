package Ex2Station;

import java.util.*;

public abstract class Affichage {
	protected Station st;
	protected String h;

	public Affichage(Station h) {
		st = h;	
	}

	public void update () {
		h = st.getData();
		System.out.println(h);
	}
}
