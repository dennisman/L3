package Ex1BD_Chimie;

import java.util.Vector;

public class OldDB {
	protected Vector<Molecule> db;
	public OldDB() {
		db = new Vector<Molecule>();
	}
	
	public void add(Molecule m){
		db.add(m);
	}
	
	Molecule oldMolecule(String n){
		for(Molecule mol : db){
			if(mol.affiche().equals(n)){
				return mol;
			}
		}
		return null;
	}
	public Vector<Molecule> getDB(){
		return db;
	}
	/*public void aff(){
		for(Molecule mol : db){
			System.out.println(mol.affiche());
		}
	}*/

}
