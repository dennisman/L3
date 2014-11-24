package ex1_antennes;
import java.util.*;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		Antenne antenne1 = new Antenne( 42, 123, 54.3, 20, 1000 );
	    Antenne antenne2 = new Antenne( 24, 32.1, 77.8, 50, 1700 );
		SortedSet<Antenne> ensAnt = new TreeSet<Antenne>();
		ensAnt.add(antenne2);
		ensAnt.add(antenne1);
		ensAnt.add( new Antenne( 21, 98.7, 266.88, 25, 2700 ) );
		
		System.out.println(antenne1 + ", largeur=" + antenne1.larg());
		System.out.println(antenne2 + ", largeur=" + antenne2.larg());
		System.out.println( ensAnt );
		
	}

}
