package Ex1;
import java.util.Vector;

public class TriFusion<E extends Comparable<E>> {
	
	
	void fusionSort(Vector<E> tab, int fst, int lst)
	{
		if (fst != lst)
		{
			int mid = (fst + lst) /2;
			fusionSort(tab, fst, mid);
			fusionSort(tab, mid+1, lst);
			fusion(tab, fst, mid, lst);
		}
	}
	
	void fusion(Vector<E> tab, int fst1, int lst1, int lst2)
	{
		int i,j,fst2,l;
		i=l=fst1;
		j = fst2 = lst1+1;
		
		// copie de la premiere moitiee du tableau
		// evite d'écraser les données
		Vector<E> copie = new Vector<E>();
		for (int k=fst1; k<=lst1; k++)
		{
		    copie.add(tab.get(k));
		}
		
		// l sert a verifier que l'on ne sort pas du tableau
		while((i != fst2) && (l <= lst2)) /* (=tant qu'il reste des cases non traitées dans au moins un des 2 tableaux) */
		{
			if(j==lst2+1)
			{
				tab.set(l, copie.get(i-fst1));
				i++;
			}
			else
			{
				if(copie.get(i-fst1).compareTo(tab.get(j)) < 0)
				{
					tab.set(l,copie.get(i-fst1));
					i++;
				}
				else
				{
					tab.set(l,tab.get(j));
					j++;
				}
			}
			l++;
		}//While
	}
}
