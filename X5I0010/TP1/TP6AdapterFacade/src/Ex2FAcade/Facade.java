package Ex2FAcade;

public class Facade {
	protected Retroprojo r;
	protected Salle s;
	protected Multiprise m;
	protected VideoProjo v;
	protected Ordi o;
	public Facade() {
		r = new Retroprojo();
		s = new Salle();
		m = new Multiprise();
		o = new Ordi();
		v = new VideoProjo();
	}

	
	/*public void debutCours(){
		s.allumerLumiere();
		m.brancheMulti();
		r.allumerRetro();
	}
	
	public void finCours(){
		s.etendreLumiere();
		m.debrancheMulti();
		r.etendreRetro();
	}*/
	
	public void debutCours(){
		s.allumerLumiere();
		m.brancheMulti();
		v.allumerVid();
		o.allumerOrdi();
	}
	
	public void finCours(){
		s.etendreLumiere();
		m.debrancheMulti();
		v.etendreVid();
		o.etendreOrdi();
	}
	
}
