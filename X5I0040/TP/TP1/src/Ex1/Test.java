package Ex1;

import java.util.Vector;
import Ex1.TriFusion;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Vector<Integer> tab ;
		tab = new Vector<Integer>();
		TriFusion<Integer> tri = new TriFusion<Integer>();
		
		tab.add(3);
		tab.add(2);
		tab.add(-1);tab.add(1);
		
		tab.add(26);
		tab.add(-86);
		tab.add(92);
		tab.add(42);
		tab.add(-56);
		tab.add(-83);
		tab.add(+23);
		tab.add(44);
		tab.add(-66);
	
		System.out.println(tab);
		tri.fusionSort(tab,0,tab.size()-1);
		System.out.println(tab);
		

	}


}
