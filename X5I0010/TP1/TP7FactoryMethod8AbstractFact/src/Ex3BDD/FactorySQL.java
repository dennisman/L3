package Ex3BDD;

public class FactorySQL extends Factory {

	public FactorySQL() {
		// TODO Auto-generated constructor stub
	}
	
	public Proxy factoryMethod(boolean secure){
		if(secure){
			return new ProxySecureSQL();
		}else{
			return new ProxySQL();
		}
	}

}
