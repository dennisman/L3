package Ex3BDD;

public class Main {


	public static void main(String[] args) {
		Factory sql = new FactorySQL();
		Factory oracle = new FactoryOracle();
		
		Proxy proxysql = sql.factoryMethod(true);
		
		proxysql.affichage();
		
		

	}

}
