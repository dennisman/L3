package ex1_antennes;
//import java.lang.AssertionError;

public class Antenne implements Comparable<Antenne> {
	protected int id;
	protected Position pos;
	protected int freqB; //borne inf freq en MHz
	protected int freqH; //borne sup freq en MHz
	
	//CONSTRUCTEUR
	public Antenne (int ide, double a, double b, int freqa, int freqb)
	{
	  pos = new Position(a,b);
	  id = ide;
	  freqB = freqa;
	  freqH = freqb;
	  assert (freqB >freqH) : "erreur de plage";
	}
		
	//ASSESSEURS
	
	public int getId()
	{
		return id;
	}
	public Position getPos()
	{
		return pos;
	}
	public int getfreqB()
	{
		return freqB;
	}
	public int getfreqH()
	{
		return freqH;
	}
	
	public void setId(int a)
	{
		id = a;
	}
	public void setPos(double a, double b)
	{
		pos.setPos(a, b);
	}
	public void setfreqB(int newfreq)
	{
		freqB = newfreq;
	}
	public void setfreqH(int newfreq)
	{
		freqH = newfreq;
	}
	
	
//METHODES
	public double dist(Position pos2)
	{
		return pos.dist(pos2);
	}
	public int larg()
	{
		return freqH-freqB;
	}
	
	public String toString()
	{
		return ("" + id + ":[" + freqB + "-" + freqH + "]@" + pos);
	}
	
// OUTILS DE COMPARAISON
	@Override
	public int compareTo(Antenne ant) {
		return larg()-ant.larg();
	}
	
}
