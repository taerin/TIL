# 느슨한 결합
클래스가 다른 클래스를 이용할 때 구체 클래스에 의존하는 것이 아닌 인터페이스에 의존하는 것을 의미한다.
이는 객체지향 5대원칙중 DIP (의존관계 역전원칙)을 의미한다.

여기서 객체지향 5대원칙을 간단하게 복습해 보자면
1) SRP(Single Responsible Principle) 단일 책임의 원칙
2) OCP(Open Close Principle) 개방 폐쇄의 원칙
3) LSP(Liscov Substitution Principle) 리스코프 치환의 원칙
4) ISP(Interface Segreation Principle) 인터페이스 분리의 원칙
5) DIP(Dependency Inversion Principle) 의존관계 역전 원칙

다시 본론으로 돌아와서
느슨한 결합의 핵심은 교체가능한 설계인데, 교체가능하려면 인터페이스가 필요하다.
__ 교체 가능한 설계 : 인터페이스 __
	* 인터페이스는 교체 가능한 유연한 디자인의 핵심
	* 나중에 클래스가 추가되어도 기존 코드는 수정될 필요가 없다. (OCP)

아래 코드는 mp3를 들을 수 있는 아이팟과 아이폰으로 사람이 음악을 듣는 상황을 코드로 나타낸 것이다.

``` java 
class iPod{
	public void play(){
		System.out.println("play music with iPod);
	}
}

class iPhone{
	public void play(){
		System.out.println("play music with iPhone);
	}
}

class Person{
	public void playMusic(iPod mp3){
		mp3.plya();
	}
}

public class LooselyCouplying{
	public static void main (String[] args){
		Person person = new Person();
		person.playMusic(new Ipod());
	}
}
```
위에서 말했듯 새로운 기능이 추가되어도 기존 코드는 수정되어서는 안된다.
하지만 위 코드에서 만약 사람이 iPod이 아닌 iPhone으로 음악을 듣게 하고자 한다면 코드의 수정이 필요하다. 
이유는 Person 클래슨는 iPod 이라는 구체 클래스에 강하게 결합되어 있기 때문이다.

위 코드를 기능은 똑같게 하되 인터페이스를 도입하여 느슨한 결합으로 리팩토링 해보겠다.

느슨한 결합으로 리팩토링하는 과정은 다음과 같다.

``` java
// 1. MP3 사용자와 제작자 사이의 규칙을 먼저 설계하자.
//  	(인터페이스, 계약서, 프로토콜)

interface MP3{
	void play();
}

// 2. "모든 MP3는 위의 인터페이스로부터 파생되어야 한다." 라고 말하지 말고 
// "모든 MP3는 위에 인터페이스를 구현해야 한다." 라고 표현한다.

class iPod implements MP3{
	public void play(){
		System.out.println("play music with iPod");
	}
}

class iPhone implements MP3{
	public void play(){
		Symstem.out.println("play music with iPhone");
	}
}

// 3. 사용자는 구체클래스를 바로사용하는 것이 아니라 인터페이스를 이용해야 한다.

class Person{
	public void playMusic(MP3 mp3){
		mp3.play();
	}
}

public class LooselyCoupling{
	public static void main(String[] args){
		Person person = new Person();
		person.playMusic(new iPhone());
		person.playMusic(new iPod());
	}
}
```

