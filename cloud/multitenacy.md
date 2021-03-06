# Software multitenancy(소프트웨어 멀티테넌시)

소프트웨어 멀티테넌시(software multitenancy)라는 용어는 소프트웨어 아키텍처의 하나를 가리키며, 여기에서 하나의 소프트웨어 인스턴스가 한 대의 서버 위에서 동작하면서 여러 개의 테넌트(tenant)를 서비스한다. 여기에서 테넌트란 소프트웨어 인스턴스에 대해 공통이 되는 특정 접근 권한을 공유하는 사용자들의 그룹이다.
멀티테넌트 구조에서 응용 소프트웨어는 데이터, 구성, 사용자 관리, 테넌트 개별 기능 및 비기능 속성을 포함하여, 모든 테넌트에게 인스턴스의 일부분을 단독적으로 제공하기 위해 설계되어 있다.
멀티테넌시는 개개의 소프트웨어 인스턴스들이 각기 다른 테넌트를 위해 운영되는 멀티인스턴스 구조와는 상반된다.

클라우드는 이미 우리 생활 깊숙이 들어와 있습니다. 파일을 저장하고, 소프트웨어를 사용하고, 동료나 친구와 협업하는 모든 일이 인터넷을 통해 클라우드를 통해 이뤄집니다. 이처럼 인터넷에서 여러 사람이 동시에 같은 작업을 하려면 소프트웨어나 서비스를 여러 사람이 공유해서 사용할 수 있어야 합니다. 그리고 이것을 가능하게 하는 것이 바로 '멀티테넌시(Multitenancy)' 아키텍처입니다.

멀티테넌시란 그 용어에서 유추할 수 있듯 여러 테넌트(tenant, 사용자)를 가진 아키텍처라는 의미입니다. 많은 사람이 같은 기능을 사용하는 웹메일 서비스가 대표적인 멀티테넌시 아키텍처 소프트웨어입니다. 여기서 중요한 것은 각 사용자가 독립적으로 이용할 수 있어야 한다는 점입니다. 웹메일에 접속했는데 모든 사용자의 메일이 하나의 메일함에서 보인다면 아무도 사용하지 않겠죠. 멀티테넌트 아키텍처 덕분에 사용자별로 데이터와 설정, 화면 구성 등 많은 속성을 개인화할 수 있게 됐고, 이 기술이 성숙하면서 비로소 클라우드도 본격 확산했다고 할 수 있습니다.

## 멀티테넌시의 역사와 장점
멀티테넌시 아키텍처는 다양한 기술이 진화, 통합한 결과물입니다. 먼저 1970년대의 IBM 메인프레임입니다. 당시 기업은 메인프레임 컴퓨터에서 저장공간과 프로세싱 파워를 필요한 만큼만 빌려 사용했습니다. 전체를 사용하기엔 너무 비쌌으니까요. 로그인 ID에 따라 CPU와 메모리, 저장공간 등을 개별적으로 할당해 사용하는 방식이었는데, 현재 AWS나 마이크로소프트 에저 등의 서비스 방식과 매우 비슷하죠?


이밖에 1990년대 등장한 ASP(Application Server Provider)와 웹 애플리케이션도 큰 영향을 줬습니다. 단, 전자는 아키텍처의 한계로 각 소프트웨어를 별도의 장비에서 운영해야 했고, 후자는 초기 앱의 경우 개인화에 한계가 있었습니다. 지금은 한 장비에 설치한 소프트웨어를 여러 사람이, 그것도 마치 다른 환경처럼 설정해 사용할 수 있으니 ASP와 초기 웹 애플리케이션의 진화된 형태가 현재의 멀티테넌시 아키텍처라고 할 수 있습니다.

멀티테넌시 아키텍처의 가장 큰 장점은 비용 절감입니다. IT 리소스를 유연하게 할당할 수 있어 규모의 경제성과 관리 비용 절감을 동시에 구현했습니다. 소프트웨어 라이선스 비용 측면에서도 같은 규모의 사용자를 기준으로 멀티테넌시 방식이 더 저렴한 경우가 많습니다. 새로운 버전이 나와도 장비 쪽 소프트웨어만 업데이트하면 모든 사용자가 새로운 기능을 사용할 수 있어 관리하기도 편합니다.

멀티테넌시 아키텍처의 또 다른 장점은 데이터 통합이 쉽다는 점입니다. 하나의 시스템과 소프트웨어를 여러 사용자가 공유하는 구조이므로 사용자별 데이터가 사실상 같은 데이터 스키마에 저장됩니다. 이 대규모 데이터를 분석하는 작업도 더 빠르게 편리해졌죠. 분석에 대한 수요가 커지고, 동시에 데이터의 양과 형식이 점점 다양해지면서 멀티테넌시 아키텍처의 장점이 더 두드러지고 있습니다.

## 장점은 곧 단점
멀티테넌시 아키텍처가 등장한 지 10년이 넘어가면서 상당한 수준까지 고도화됐습니다. 같은 소프트웨어를 사용해도 사용자 혹은 기업고객별로 메뉴 구성과 디자인 등 이른바 '룩앤필(look and feel)'을 완전히 다른 형태로 구성할 수 있습니다. 기업별 고유의 업무 절차 차이까지도 반영해 소프트웨어를 수정할 수 있고 특히 특정 기업단위 사용자 중 일부에게 특정 권한과 제한을 하는 것도 가능해졌습니다.

그럼에도 불구하고 멀티테넌시에는 몇 가지 단점이 있습니다. 예를 들어 개인화를 지원하기 위해서는 더 정교한 멀티테턴시 아키텍처를 적용해야 하는데 이를 개발하는 입장에서는 상당한 비용과 인력이 필요합니다. 업데이트 과정에서 자칫 버그나 장애가 발생하면 모든 사용자가 공통으로 장애를 겪을 수 있고, 또 일부 사용자에게 유용한 업데이트가 다른 사용자에게는 오히려 불편함을 유발할 수도 있습니다.

가장 논란이 되는 것은 보안입니다. 외부적으로는 사용자별로 다른 것처럼 보인다고 해도 결국 멀티테넌시 아키텍처 내부적으로는 단일 데이터베이스에 다양한 사용자의 데이터가 공존하게 됩니다. 따라서 사용자별 데이터가 서로 섞이지 않도록 해야 하고, 해킹이라도 발생하면 해당 장비를 사용하는 모든 사용자의 데이터가 동시에 유출되지 않도록 더 강력한 보안 체계를 갖춰야 합니다.


[출처](https://ko.wikipedia.org/wiki/멀티테넌시)
