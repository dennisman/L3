package Ex1int;
import java.util.*;
public abstract class Decorator extends Entier {
	protected Entier ent;

	public Decorator(Entier x) {
		ent=x;
		//System.out.println("debug ent " + ent.entier + ent.integ + getClass());
	}
	
	public void base(){
		super.base();
	}
	public String getString(){
		return ent.getString();
	}
	public int getInt(){
		return ent.getInt();
	}

}
