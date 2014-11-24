package Ex2_AB;

import java.util.*;

public class NoeudBinaire<E extends Comparable<E>>{
	protected E etq;
	protected NoeudBinaire<E> leSon;
	protected NoeudBinaire<E> riSon;
	protected int nbFils;
	
	
	
	
	//CONSTRUCTEUR
	public NoeudBinaire(E base)
	{
		etq = base;
		nbFils=0;
	}
	
	// Methodes
	
	public boolean isLeaf()
	{
		return nbFils==0;
	}
	public boolean isFull()
	{
		return nbFils==2;
	}
	public boolean hasLSon()
	{
		return nbFils!=0;
	}
	public boolean hasRSon()
	{
		return nbFils==2;
	}
	
	
	
	//AJOUTS DE FILS
	public void addLSon(NoeudBinaire<E> son)
	{
		leSon = son;
		nbFils++;
	}
	public void addRSon(NoeudBinaire<E> son)
	{
		riSon = son;
		nbFils++;
	}
	public void addSon(NoeudBinaire<E> son)
	{
		E val = son.etq;
		if (etq.compareTo(son.etq)<0)
		{
			if (isLeaf())
			{
				addLSon(son);
			}
			else
			{
				leSon.addSon(son);
			}
		}
		else
		{
			if (isLeaf())
			{
				addRSon(son);
			}
			else
			{
				leSon.addSon(son);
			}
		}
	}
	
	
	//RECHERCHE 
	public NoeudBinaire<E> find(E elt)
	{
		assert isIn(elt);
		if (etq == elt)
		{
			return this;
		}
		else
		{
			if (leSon.isIn(elt))
			{
				return leSon.find(elt);
			}
			else
			{
				return riSon.find(elt);
			}
		}
	}
	
	public boolean isIn(E elt)
	{
		if (isLeaf())
		{
			return false;
		}
		else
		{
			if (etq == elt)
			{
				return true;
			}
			else
			{
				if (leSon.isIn(elt) || riSon.isIn(elt))
				{
					return true;
				}
				else
				{
					return false;
				}
				
			}
		}
	}
	
	
	//Affichage
	private void getSym(String res)
	{
		if (hasLSon())
		{
			leSon.getSym(res);
		}
		res += etq.toString();
		if (hasRSon())
		{
			riSon.getSym(res);
		}
	}
	
	public void printSym()
	{
		String res= "";
		getSym(res);
		
		System.out.println(res);
	}
	
	
	
	
	
	
	//GETTEURS
	public NoeudBinaire<E> leftSon()
	{
		return leSon;
	}
	
	public NoeudBinaire<E> rightSon()
	{
		return riSon;
	}
	
	public E getEtq()
	{
		return etq;
	}
	public int getNbFils()
	{
		return nbFils;
	}


}
