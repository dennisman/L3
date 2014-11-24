package Ex2Station;

public class Moyenne extends Affichage {

	public Moyenne(Station h) {
		super(h);
	}

	public void update () {
		h = st.moyenne().toString();
		System.out.println(h);
	}

}
