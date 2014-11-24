package Ex2_AB;

public class ArbreBinaire<E> {
	private NoeudBinaire<E> racine;
	private int sz;
	
	public ArbreBinaire(E rac)
	{
		racine = new NoeudBinaire<E>(rac);
		sz = 0;
	}
	
	public int size()
	{
		return sz;
	}
	public NoeudBinaire<E> getRacine()
	{
		return racine;
	}
	
	
	// ajouts
	public addNoeud(NoeudBinaire<E> n)
	{
		
	}

}
