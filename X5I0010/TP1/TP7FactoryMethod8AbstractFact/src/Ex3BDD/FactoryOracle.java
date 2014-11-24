package Ex3BDD;

public class FactoryOracle extends Factory{

	public FactoryOracle() {
		// TODO Auto-generated constructor stub
	}

	
	public Proxy factoryMethod(boolean secure){
		if(secure){
			return new ProxySecureOracle();
		}else{
			return new ProxyOracle();
		}
	}
}
