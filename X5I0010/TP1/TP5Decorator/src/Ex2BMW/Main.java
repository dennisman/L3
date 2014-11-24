package Ex2BMW;

import java.io.*;

public class Main {

	public static void main(String[] args) {
		BMW b325 = new BM325("diesel", 10000);
		BMW b330 = new BM330("essence", 10000);
		
		System.out.println(b325.cout());
		System.out.println(b330.cout());
		
		
		System.out.println("----------------");
		
		
		b325 = new Metalisee(b325);
		b330 = new Gps(b330);
		
		System.out.println(b325.cout());
		System.out.println(b330.cout());
		
		
		System.out.println("----------------");
		
		b325 = new Gps(b325);
		
		System.out.println(b325.cout());
		System.out.println(b330.cout());
		
		
		
		
	}

}
