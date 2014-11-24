package Ex1Edt;

public class ChoixMath implements Facto {

	public ChoixMath() {
		// TODO Auto-generated constructor stub
	}

	public Sale choixSalle() {
		// TODO Auto-generated method stub
		return new SalleMath();
	}

	@Override
	public Prof choixProf() {
		// TODO Auto-generated method stub
		return new ProfMath();
	}

}
