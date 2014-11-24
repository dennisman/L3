package Ex2Station;



public class Main {

	public static void main(String[] args) {
		Station horloge = new StationConcrete();
		Affichage num = new Courant(horloge);
		Affichage anal = new Moyenne(horloge);

		
		

		horloge.add(num);
		horloge.add(anal);
		
		/*while(true){
			try{
			Thread.sleep(1000);
			}
			catch(InterruptedException e){
				
			}*/
			horloge.notif();
		/*}

	}*/
			horloge.notif();
			horloge.notif();
}
}
