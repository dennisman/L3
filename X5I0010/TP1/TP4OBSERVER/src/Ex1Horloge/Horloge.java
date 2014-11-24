package Ex1Horloge;
import java.*;
import java.util.*;

public abstract class Horloge {

	protected Vector<Affichage> obs;
	protected Date h;

	public Horloge() {
		obs = new Vector<Affichage>();
	}

	public void add (Affichage ob) {
		obs.add(ob);
	}

	public void supp (Affichage ob) {
		obs.remove(ob);
	}

	public void notif () {
		h = new Date();
		for(Affichage o : obs){
			o.update();
		}
	}
	public String getClock(){
		return (h.toString());
	}
	

}
