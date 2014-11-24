package Ex1BD_Chimie;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Molecule eau = new Molecule("eau", "H2O");
		Molecule ethanol = new Molecule("ethanol", "cooh");
		
		
		OldDB old = new OldDB();
		old.add(eau);
		
		
		NewDB adap = new AdapterMol(old);
		//NewDB nouv = new NewDB();
		
		adap.add(ethanol);
		

	
		System.out.println( adap.newMolecule("eau").affiche() );
		System.out.println( adap.newMolecule("ethanol").affiche() );
		
		
		
		
		
	}

}
