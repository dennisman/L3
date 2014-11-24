package Ex1Horloge;

public class Main {


	public static void main(String[] args) {
		Horloge horloge = new HorlogeConcrete();
		Affichage num = new Numérique(horloge);
		Affichage anal = new Analogique(horloge);
		
		
		horloge.add(anal);
		horloge.add(num);
		
		while(true){
			try{
			Thread.sleep(1000);
			}
			catch(InterruptedException e){
				
			}
			horloge.notif();
		}
		

	}

}
