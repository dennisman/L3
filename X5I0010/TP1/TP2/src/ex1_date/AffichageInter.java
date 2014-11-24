package ex1_date;
import java.text.*;
import java.util.*;

public class AffichageInter implements StrategyAffichage {

	@Override
	public String getDate(Date d) {
		DateFormat formatIntl = new SimpleDateFormat("yyy-MM-dd");
		return formatIntl.format(d);
	}

}
