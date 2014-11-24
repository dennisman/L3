package Ex1Edt;

public class Cours {
	private Sale salle;
	private Prof prof;
	public Facto creerCours;
	
	
	public Cours(Facto f) {
		salle = f.choixSalle();
		prof = f.choixProf();
	}
	
	public void affichage(){
		salle.affichage();
		prof.affichage();
	}

}
