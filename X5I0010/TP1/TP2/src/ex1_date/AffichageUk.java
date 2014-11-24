package ex1_date;

import java.text.*;
import java.util.*;

public class AffichageUk implements StrategyAffichage {

	@Override
	public String getDate(Date d) {
		DateFormat formatUk = DateFormat.getDateInstance( DateFormat .SHORT, Locale.UK ) ;
		return formatUk.format(d);
	}

}
