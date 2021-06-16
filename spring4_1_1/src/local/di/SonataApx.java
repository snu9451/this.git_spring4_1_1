package local.di;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SonataApx {
	public static void main(String[] args) {
//		Sonata herCar = new Sonata();
		
		ApplicationContext context = 
				new ClassPathXmlApplicationContext("local\\di\\sonataBean.xml");
		
		Sonata myCar = null;
		myCar = (Sonata)context.getBean("myCar");
		System.out.println(myCar.toString());
		
		Sonata yourCar = null;
		yourCar = (Sonata)context.getBean("yourCar");
		System.out.println(yourCar.toString());
		System.out.println("yourCar의 현재속도는 " + yourCar.getSpeed() + "입니다.");
		
		//////////////////////////////////////////////////////////////////////
		Sonata meCar = null;
		meCar = (Sonata)context.getBean("meCar");
		System.out.println(meCar.toString());
		System.out.println("meCar의 현재속도는 " + meCar.getSpeed() + "입니다.");
		
		Sonata himCar = null;
		himCar = (Sonata)context.getBean("himCar");
		System.out.println(himCar.toString());
		System.out.println("himCar의 현재속도는 " + himCar.getSpeed() + "입니다.");
	}
}
