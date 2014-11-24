package Ex2Station;

public class Data {
	public double temp;
	public double pres;
	public double hum;
	
	public Data(double t,double p, double h) {
		temp = t;
		pres = p;
		hum = h;
	}

	public String toString(){
		return ("temperature " + temp + ", pression "+pres + ", humidite " + hum );
	}

}
