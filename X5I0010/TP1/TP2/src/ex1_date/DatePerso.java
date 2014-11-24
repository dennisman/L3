package ex1_date;

import java.util.*;

public class DatePerso {
	private Date date;
	private StrategyAffichage affichagetype;

	public DatePerso() {
		date = new Date();
		affichagetype = new AffichageInter(); // par défaut
	}

	public void affichage () {
		System.out.println(affichagetype.getDate(date));
	}
	
	public void setAffichage(StrategyAffichage aff)
	{
		affichagetype = aff;
	}
	

}
