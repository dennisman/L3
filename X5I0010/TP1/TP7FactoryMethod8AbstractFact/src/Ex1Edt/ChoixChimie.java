package Ex1Edt;

public class ChoixChimie implements Facto {

	public ChoixChimie() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Sale choixSalle() {
		// TODO Auto-generated method stub
		return new SalleChimie();
	}

	@Override
	public Prof choixProf() {
		// TODO Auto-generated method stub
		return new ProfChimie();
	}

}
