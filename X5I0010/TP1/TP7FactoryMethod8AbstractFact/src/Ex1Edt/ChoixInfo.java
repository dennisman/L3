package Ex1Edt;

public class ChoixInfo implements Facto {

	public ChoixInfo() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Sale choixSalle() {
		// TODO Auto-generated method stub
		return new SalleInfo();
	}

	@Override
	public Prof choixProf() {
		// TODO Auto-generated method stub
		return new ProfInfo();
	}

}
