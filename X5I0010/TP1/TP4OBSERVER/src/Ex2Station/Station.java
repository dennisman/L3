package Ex2Station;

import java.util.*;



public abstract class Station {

	protected Vector<Affichage> obs;
	protected Vector<Data> donnees;

	public Station() {
		//double t = 0 + Math.random() * (35 - 0);
		//double p = 950 + Math.random() * (1200 - 950);
		//double h = 0 + Math.random() * (70 - 0);
		obs = new Vector<Affichage>();
		donnees = new Vector<Data>();
		//donnees.add(new Data(t, p, h));
	}

	public void add(Affichage num) {
		obs.add(num);
	}

	public void supp(Affichage ob) {
		obs.add(ob);
	}

	public void notif() {
		double t = 0 + Math.random() * (35 - 0);
		double p = 950 + Math.random() * (1200 - 950);
		double h = 0 + Math.random() * (70 - 0);
		donnees.add(new Data(t, p, h));
		for (Affichage o : obs) {
			o.update();
		}
	}
	public String getData(){
		return donnees.lastElement().toString();
	}
	public Vector<Data> getDonnees(){
		return donnees;
	}
	public Data moyenne(){
		double t=0.0, p=0.0, h=0.0;
		for (Data d : donnees){
			t+= d.temp/donnees.size();
			p+= d.pres/donnees.size();
			h+= d.hum/donnees.size();
		}
		
		Data result = new Data(t,p,h);
		return result;
	}

}
