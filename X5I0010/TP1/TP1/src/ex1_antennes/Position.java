package ex1_antennes;

public class Position {
	protected double x;
	protected double y;
	
	
//CONSTRUCTEUR
	public Position (double a, double b)
	{
		x = a;
		y = b;
	}
	
//ASSESSEURS
	public void setPos(double a, double b)
	{
		x = a;
		y = b;
	}
	
	public double getX()
	{
		return x;
	}
	public double getY()
	{
		return y;
	}
	
	
	public String toString()
	{
		return ("(" + x + "," + " " + y + ")");
	}
	
//METHODES
	
	public double dist(Position pos)
	{
		double res = Math.hypot((x-pos.x),(y-pos.y));
		return res;
	}

}
