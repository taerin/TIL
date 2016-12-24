# Composite pattern
-----
 컴포지트 패턴(Composite pattern)이란 객체들의 관계를 트리 구조로 구성하여 부분-전체 계층을 표현하는 패턴으로, 사용자가 단일 객체와 복합 객체 모두 동일 하게 다루도록 한다.

## 핵심 2가지
1) 복합 객체(PopupMenu)는 단일 객체(MenuItem)와 복합 객체를 모두 보관한다.
=> 공통의 부모(BaseMenu)가 필요하다.

2) 복합 객체와 단일 객체는 동일시 된다.
=> 사용법이 같다.(모두 command()를 사용한다.)

``` java
// 자식의 공통된 속성을 반드시 부모에도 제공해야 한다.
abstract class BaseMenu {
	private String title;

	public BaseMenu(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	// 모든 메뉴는 선택되면 command() 가 호출된다.
	// 부모 입장에서 구현해 줄 필요가 없고
	// 자식이 반드시 제공해야 한다면 추상 메소드로 설계해야 한다.
	public abstract void command();
}


class MenuItem extends BaseMenu {
	public MenuItem(String title) {
		super(title);
	}

	@Override
	public void command() {
		System.out.println(getTitle() + " 선택되었음.");
	}
}

class PopupMenu extends BaseMenu {
	// 재귀적 합성 - 자기가 자기 자신을 포함할 수 있는 형태의 설계
	private List<BaseMenu> menus = new ArrayList<>();

	public void addMenu(BaseMenu menu) {
		menus.add(menu);
	}

	public PopupMenu(String title) {
		super(title);
	}

	@Override
		public void command() {
		Scanner scanner = new Scanner(System.in);

		while (true) {
			System.out.println();

			int size = menus.size();
			for (int i = 0 ; i < size ; ++i) {
				System.out.printf("%2d. %s\n", i + 1, menus.get(i).getTitle());
			}
			System.out.printf("%2d. 상위 메뉴로\n", size + 1);
			System.out.print("메뉴를 선택하세요 >> ");

			int cmd = scanner.nextInt();
			if (cmd < 1 || cmd > size + 1)
				continue;

			if (cmd == size + 1)
				break;

			menus.get(cmd - 1).command();
			}
	}
}


public class MenuSystem {
	public static void main(String[] args) {
		PopupMenu menuBar = new PopupMenu("메뉴바");

		PopupMenu p1 = new PopupMenu("화면 설정");
		PopupMenu p2 = new PopupMenu("소리 설정");

		menuBar.addMenu(p1);
		p1.addMenu(p2);
		// menuBar.addMenu(p2);

		p1.addMenu(new MenuItem("해상도 변경"));
		p1.addMenu(new MenuItem("색상 변경"));
		p1.addMenu(new MenuItem("명암 변경"));

		p2.addMenu(new MenuItem("볼륨 조절"));
		p2.addMenu(new MenuItem("음향 조절"));

		menuBar.command();
	}
}
```


