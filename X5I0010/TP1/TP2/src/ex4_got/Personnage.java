package ex4_got;

public abstract class Personnage {
	protected ComportementArme arme;

	public Personnage() {
		arme = new ComportementEpee();
	}
	public Personnage(ComportementArme ar) {
		arme = ar;
	}
	public void combattre () {
		arme.utiliserArme();
	}
	public void setArme(ComportementArme ar)
	{
		arme= ar;
	}
}