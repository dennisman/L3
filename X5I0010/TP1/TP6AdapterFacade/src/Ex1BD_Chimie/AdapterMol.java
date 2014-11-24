package Ex1BD_Chimie;

public class AdapterMol extends NewDB {
	protected OldDB odb;
	
	public AdapterMol(OldDB o) {
		odb = o;
	}

	
	Molecule newMolecule(String n){
		for(Molecule mol : db){
			if(mol.affiche().equals(n)){
				return mol;
			}
		}
		for(Molecule mol : odb.getDB()){
			if(mol.affiche().equals(n)){
				return mol;
			}
		}
		return null;
	}
}
