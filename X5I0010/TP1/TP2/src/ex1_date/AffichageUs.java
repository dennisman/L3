package ex1_date;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

public class AffichageUs implements StrategyAffichage {

	@Override
	public String getDate(Date d) {
		DateFormat formatUs = DateFormat.getDateInstance( DateFormat .SHORT, Locale.US ) ;
		return formatUs.format(d);
	}

}
