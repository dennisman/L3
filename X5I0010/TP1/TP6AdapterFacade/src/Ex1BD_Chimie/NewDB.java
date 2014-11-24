package Ex1BD_Chimie;

import java.util.Vector;

public class NewDB {
	protected Vector<Molecule> db;
	public NewDB() {
		db = new Vector<Molecule>();
	}
	
	public void add(Molecule m){
		db.add(m);
	}
	
	Molecule newMolecule(String n){
		for(Molecule mol : db){
			if(mol.affiche().equals(n)){
				return mol;
			}
		}
		return null;
	}
	/*
	public void aff(){
		for(Molecule mol : db){
			System.out.println(mol.affiche());
		}
	}*/

}