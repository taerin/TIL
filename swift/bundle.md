# Bundle
-----
번들은 실행코드와 이미지, 사운드, 문자열, nib 파일과 같은 관련된 리소스의 모음이다. 번들은 각 리소스의 다른 버전을 동시에 저장할 수 있어서 하나의 실행코드가 사용자의 언어나 지역 설정에 따라 다른 버전의 리소스를 사용할 수 있게 한다. 번들 패턴은 실행코드와 리소스를 정리하고 동적으로 로드할 수 있는 기법을 제공한다.

다른 디자인패턴들과 마찬가지로 번들 패턴은 코코아 외의 다른 객체 지향 개발 환경에서도 존재한다. 
자바에서는 번들을 JAR(Java ARchive)로 구현하는데, 이 파일은 자바 클래스와 리소스를 압축된 단일 파일로 파일 시스템에 저장한다. JAR 파일은 리소스 파일 구조의 복잡성이 JAR 파일 내로 숨겨져 있기 때문에, 복사와 다운로드가 쉽다.
그러나 JAR 파일 내에 코드가 아닌 리소스를 정리하는 표준이 존재하지 않아 따고 개발된 애플리케이션 간의 JAR 파일을 공유하기 어렵다.

## 패턴이 만들어진 동기
*  실행코드와 관련된 리소스가 내부 저장공간에서 여러 버전과 여러 파일로 구성되어 있는 경우에도, 한 곳에 모을 수 있다.
* 실행코드와 리소스를 동적으로 로드할 수 있도록 하는 유연한 플러그인 기법을 구현한다.

## 패턴으로 문제 해결
코코아 프레임워크는 관련된 파일, 코드, 리소스 파일 시스템 디렉토리를 사용하여 번들 패턴을 구현한다. 이런 디렉토리를 번들이라고 부르고 파일로 이뤄진 계층 구조를 담고 있다. 
Mac OSX 에서는 프로그래밍 언어와 사용하는 프레임워크에 상관없이 애플리케이션, 프레임워크, 플러그인을 구성하는 파일을 정리하고자 할 때 번들을 사용하는 것이 가장 선호된다.
각 번들은 반드시 다른 정보와 유일무이한 번들 식별자 문자열을 저장하고 있는 Info.plist(자바의 매니페스트파일)파일을 포함하고 있어야 한다.
Info.plist 파일은 어느 텍스트 편집기에서든 열어, 실제로 번들을 애플리케이션에 로드하지 않고도 번들에 대한 정보를 확인 할 수 있다.

예를 들어 Contents 폴더에 모든 번들 리스트를 담고 있다고 하면, MacOS 폴더는 애플리케이션의 실행파일을 담고있다(Contents 하위 디렉토리). Resource 폴더는 애플리케이션이 필요로하는 인터페이스 빌더파일, 그래픽, 문자열, 그밖의 리소스 파일을 담고있다. 리소스의 지역별 버전은 .lproj라는 확장이 붙는 이름을 갖는 폴더 내에 위치한다. 이들 파일은 모두 번들 내에 특정한 위치에 담겨있다. 

## 정리
애플리케이션에 번들을 항상 사용해야 하는 것은 아니다. 파운데이션 킷 프레임워크를 사용하는 독립형 코코아 커맨드라인 프로그램과 번들 없이 독립적으로 실행되는 프로그램만 만들어내는 것도 가능하다. 그러나 애플리케이션 킷 프레임워크를 사용하는 코코아 프로그램은 거의 언제나 번들로 구현되어 있고 코코아 프레임워크 자체도 번들로 저장되어 있다.
애플리케이션이나 다른 번들을 제작 할 때, Xcode는 자동으로 이미지, 사운드, .nib, .strings 파일과 같은 표준 리소스를 자신이 속하는 곳에 위치시킨다
.

## 패턴 사용의 장단점
* 장점: 사용자가 해당하는 리소스 타입에 맞는 표준 애플리케이션으로 각 번들의 내용물을 보고 편집 하는 것이 가능하다.
* 단점: 사용자가 여러분의 애플리케이션의 리소스를 언제든 확인, 수정, 삭제가 가능하다는 것이다.