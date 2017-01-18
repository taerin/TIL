# Android Resource 형식과 저장 위치 
애플리케이션은 소스코드와 리소스로 구성되는데  안드로이드 어플리케이션은 리소스를 좀 더 적극적으로 활용한다. 즉, 레이아웃이나 메뉴, 심지어 간단한 그래픽 도형마저도 소스코드가 아닌 리소스를 통해 구현할 수 있게 한다.
	* 소스코드: 해당 어플리케이션이 동작해서 처리하고자 하는 기능을 가리킨다.
	* 리소스: 해당 어플리케이션이 동작할 때 사용하는 텍스트 문자열, 이미지, 아이콘, 오디오, 동영상 등을 가리킨다. 

## 안드로이드 어플리케이션의 리소스 관리
안드로이드 어플리케이션에서 리소스는 /res 디렉토리 안에서 관리되는데, 각 리소스 종류에 따라 /res 디렉토리 밑에 다양한 하위 디렉토리를 정의하여 관리된다.

Resource 형식 | 폴더(/res/) | 파일명 (권장사항) | element / 비고
-------------|------------|--------------|-------------
String | values | strings.xml |  <string> 요소를 정의한 어떤 XML 파일도가능 
String Array | values | arrays.xml |  <string-array> 요소를 정의한 어떤 XML 파일도 가능 
Color | value | values | colors.xml |  <color> 요소를 정의한 어떤 XML 파일도 가능 
Dimension | values | dimens.xml | <dimen> 요소를 정의한 어떤 XML 파일도 가능 
Simple drawables | values | drawables.xml | <drawable>
Style & Theme | values | styles.xml themes.xml | styles.xml, themes.xml<권장>, <style> 요소를 정의한 어떤 XML 파일도 가능 
Bitmap graphics | drawable | *.png, *.jpg, *.xml | png, jpg, gif 등 각종 이미지 파일, 도형을 정의한 XML 파일 
Animations |  anim | *.xml | <set> 루트 요소 밑에 <alpha>, <scale>, <translate>, <rotate> 등을 정의한 어떤 XML 파일도 가능 
Menu | menu | *.menu |  <menu> 루트 요소 밑에 <item>, <group> 등을 정의한 어떤 XML 파일도 가능 
XML | xml | *.xml | 개발자 임의로 정의하는 모든 XML 파일 
Raw file | raw | *.mp3, *.mp4, *.txt | mp3, mpg, txt, exe 등 각종 원본 파일 
Layout | layout | .xml | main.xml 이 일반적으로 첫 화면에 대한 레이아웃을 정의한 XML 파일이며, 각 화면 별로 레이아웃을 개별 XML로 정의 가능 


## 기본 res(리소스) 정의 및 사용법
문자열, 문자열 배열, 색상, 크기 같은 단순 리소스 정보들은 모두 /res/values 디렉토리 밑에 XML 파일로 정의
<resource> 루트 요소 밑으로 각각의 리소스를 정의

### 문자열 리소스
	* 문자열 리소스는 /res/values 디렉토리 밑에 strings.xml을 통해 관리된다.
	* 이 때 반드시 strings.xml일 필요는 없으며, <resources>를 루트 요소로 정의한 어떤 XML 파일이어도 상관없으나 XML 리소스 파일은 반드시 /res/values 디렉토리에 있어야 한다.
	* 문자열 리소스를 정의하기 위한 XML 요소는 <string> 이다.
	* 문자열 이름: name 속성 지정 / 안드로이드 어플리케이션 내에서 전역 변수처럼 사용되므로, 식별자로써 역할을 할 수 있게 고유해야 한다.
	* 문자열 값: <string> 요소의 내용으로 지정


#### 1. string
[resource]
``` xml
<string name="category1">도서</string>
<string name="category2">음반</string>
```

[use]
``` java
String myResourceString = getResources().getString(R.string.category1); 
```


### 2. 문자열 배열 리소스
	* 문자열 배열 리소스는 /res/values/ 디렉토리 밑에 arrays.xml을 통해 관리된다. 
	* 이 때 반드시 arrays.xml일 필요는 없으며, <resources>를 루트 요소로 정의한 어떤 XML 파일이어도 상관없으나 XML 리소스 파일은 반드시 /res/values 디렉토리에 있어야 한다. 
	* 문자열 리소스를 정의하기 위한 XML 요소는 <string-array> 이다
	* 문자열 배열 이름: name 속성 지정, 안드로이드 어플리케이션 내에서 전역 변수처럼 사용되므로, 식별자로써 역할을 할 수 있게 고유해야 한다.
	* 문자열 배열의 각 문자열 값: <string-array> 밑에 <item>들로 지정


#### 2. string-array
[resource]
``` xml
 <string-array name="fruits">
        <item>사과</item>
        <item>오렌지</item>
        <item>수박</item>
 </string-array> 
 <string-array name="coworker">
        <item>@string/name1</item>
        <item>@string/name2</item>
        <item>@string/name3</item>
 </string-array>
```

[use]
``` java
String[] aGreens = getResources().getStringArray(R.array.fruits);
```

### 3. 색상 리소스
	* 색상 리소스는 /res/values 디렉토리 밑에 colors.xml을 통해 관리된다.
	* 이 때 반드시 colors.xml일 필요는 없으며, <resources>를 루트 요소로 정의한 어떤 XML 파일이어도 상관없으나 XML 리소스 파일은 반드시 /res/values 	디렉토리에 있어야 한다.
	* 색상 리소스를 정의하기 위한 XML 요소는 <color> 이다.
	* 색상 이름: name 속성 지정, 안드로이드 어플리케이션 내에서 전역 변수처럼 사용되므로, 식별자로써 역할을 할 수 있게 고유해야 한다.
	* 색상 값: <color> 요소의 내용으로 지정, 비트 수 와 알파(투명도) 여부에 따라서 다음과 같이 네 가지 형태로 정의된다. (각각의 색상을 결정하는 인자 값은 16진수로 정의된다.)

색상 예)
#RGB               ex> #F00, 12비트 빨강
#ARGB             ex> #8F00, 12비트 투명도 50% 빨강
#RRGGBB         ex> #FF0000, 24비트 빨강
#AARRGGBB     ex> #80FF0000, 24비트 투명도 50% 빨강 

#### 3. color

[resource]
``` xml
<color name="backgroundColor">#ff0000</color>
```

[use]
``` java
int myBackColor = getResources().getColor(R.color.backgroundColor);
```

### 4. 크기 리소스
	* 크기 리소스는 /res/values 디렉토리 밑에 dimens.xml 을 통해 관리된다.
	* 이 때 반드시 dimens.xml일 필요는 없으며, <resources>를 루트 요소로 정의한 어떤 XML 파일이어도 상관없으나 XML 리소스 파일은 반드시 /res/values/ 디렉토리에 있어야 한다.
	* 크기 리소스를 정의하기 위한 XML 요소는 <dimen> 이다.
	* 크기 이름: name 속성 지정, 안드로이드 어플리케이션 내에서 전역 변수처럼 사용되므로, 식별자로써 역할을 할 수 있게 고유해야 한다.
	* 크기 값: <dimen> 요소의 내용으로 지정, 다양한 크기 단위들에 따라 크게 여섯 가지 형태로 정의된다.
단위 | 설명 | 단위 접미사 | 예시 
----|-----|---------|-----
픽셀 | 실제 화면 픽셀 | px | 24px
인치 | 물리적 길이 | in | 4in
밀리미터 | 물리적 길이 | mm | 2mm
포인트 | 글자 크기 단위 | pt | 12pt
밀도 독립적 픽셀 | 160dpi 화면을 기준으로 한 픽섹 | db | 1db
축척 독립적 픽셀 | 가변 글꼴 표시에 최적인 픽셀 | sp | 12sp


#### 4. dimension (크기)
[resource]
``` xml
<dimen name="menuTextSize">18pt</dimen>
```

[use]
``` java
float textSize = getResources().getDimension(R.dimen.menuTextSize);
``` 

### 5. 이미지 리소스
	* 이미지 파일들은 /res/drawable 디렉토리 밑에서 관리된다.
	* 이미지 파일을 해당 안드로이드 어플리케이션의 리소스에 등록하려면 단순히 /res/drawable 디렉토리에 추가하기만 하면 된다

이미지 형식 | 설명 | 확장자
---------|-----|--------
PNG(Portable Network Graphics) | 권장됨.(무손실) | .png 
9-patch PNG | 권장됨.(무손실) | .9.png 
JPG(Joint Photographic Experts Group) | 권장되지 않음.(유손실) | .jpg, jpeg 
GIF(Graphics Interchange Format) | 사용하지 않는 것을 권장함. | .gif 

* 9-patch PNG
이미지를 아홉 조각으로 나눠서 해당 이미지를 확대, 축소할 때 각 조각 별로 비례 여부와 방향이 다르도록 설정된 이미지임.
이는 안드로이드 고유의 이미지 형식으로, draw9patch 라는 툴(안드로이드 SDK 내/tools 디렉토리에 존재)을 사용하여 PNG 파일을 9-patch PNG로 변환할 수 있다.



### 5. drawable

1) 
[resource]
``` xml
<drawable name="redRect">#F00</drawable>
```

[use]

``` java
ColorDrawable myDraw = (ColorDrawable)getResources().getDrawable(R.drawable.redRect);
``` 

2)
[resource]
/res/drawable/egg.png

[use]

``` java
ImageView eggImage = (ImageView)findViewById(R.id.ImageView01);
eggImage.setImageResource(R.drawable.egg);
``` 

### 6. XML 파일 res(리소스)
개발자가 정의한 임의의 커스텀 XML 파일을 안드로이드 어플리케이션의 리소스로 포함시킬 수 있다. 이와 같은 XML 파일들은 /res/xml 디렉토리 밑에서 관리된다. XML 파일을 해당 안드로이드 어플리케이션의 리소스에 등록하려면 단순히 /res/xml 디렉토리에 추가하기만 하면 된다.

### 7. 기타 원본 파일 res(리소스)
안드로이드 어플리케이션의 리소스 : mp3, txt 등 각종 원본 파일 /res/raw 디렉토리 밑에서 관리된다. 원본파일을 해당 안드로이드 어플리케이션의 리소스에 등록하려면 /res/raw/ 디렉토리에 추가하기만 하면 된다. 기타 원본파일 리소스의 용도 : 안드로이드 어플리케이션의 사운드나 배경음악 등을 위한 오디오 파일들을 저장하는 리소스로 사용된다.

### 8. 멀티 리소스 관리
동일한 리소스를 다양한 언어, 지역, 모바일 기기의 특성에 따라 분리하여 관리하는 방법. 각 리소스 디렉토리 이름에 한정자 추가 기능 -> 언어와 지역, 다양한 모바일 기기의 구성 등에 따라 리소스를 분리하여 관리할 수 있도록 한다. 다양한 어플리케이션 구동 환경에 따라 적합한 리소스를 적용할 수 있게 하여, 한드로이드 어플리케이션의 유연성 및 확장성을 강화시킨다.	
	* 언어와 지역에 따른 리소스 관리 : 안드로이드 어플리케이션의 현지화(Localization)을 용이하게 한다.

항목 | 한정자 | 설명 | 예제
-----|------|-----|-----
언어 | ko, en, fr, es, zh, ja, de 등 | ISO 639-1에서 정의한 두글자 언어 코드 | /res/values-en (영어에 대한 리소스 관리) /res/drawable-ko (한국어에 대한 리소스 관리)
지역 | rKR, rUS, rGB, rFR, rES, rCN, rJP, rDE 등 | ISO-3166-1-alpha-2 에서 정의한 두글자 지역 코드, 소문자 "r"을 맨 앞에 붙여야 한다. | /res/values-zh-rCN (중국어, 중국에 대한 리소스 관리) /res/values-en-rGB (영어, 영국에 대한 리소스 관리) 

	* 모바일 기기의 특성에 따른 리소스 관리 : 안드로이드 어플리케이션을 모바일 기기의 특성에 따라 세밀하게 관리할 수 있다.

항목 | 한정자 | 설명 | 예제
-----|------|-----|----
화면크기 | small, normal, large | 저화질의 QVGA(=320*240) 화면, 중간 화질의 HVGA(=320*480/640*240) 화면, 중간 화질의 VGA(=640*480) 화면 | /res/drawable-large (VGA 화면에 대한 리소스 관리) 
화면비율 | long, normal | W급(WQVGA, WVGA, FWVGA 등) 긴 화면, 일반 (QVGA, HVGA, VGA 등) 화면 | /res/drawable-long (W급 긴 화면에 대한 리소스 관리) 
화면 방향 | port, land, square | 세로모드, 가로모드, 정사각형 화면 | /res/drawable-port (세로 모드에 대한 리소스 관리) 
독(Dock) 모드 | car, desk | 차 독에 연결, 데스크 독에 연결 | /res/drawable-port/desk (세로 모드로 데스크 독에 연결 할 때에 대한 리소스 관리) 
나이트 모드 | night, notnight | 밤, 낮 | /res/drawable-night (밤에 사용할 수 있는 리소스 관리) 
화면 화질 | ldpi, mdpi, hdpi, nodpi | 저화질 120dpi, 중간 화질 160dpi, 고화질 240dpi, 모바일 기기의 화질에 맞추지 않음 | /res/drawable-hdpi (고화질 이미지에 대한 리소스 관리), /res/drawable-port-Idpi (세로 모드 저화질 이미지에 대한 리소스 관리) 
터치스크린 종류 | notouch, stylus, finger | 터치 스크린 없음, 스타일러스 전용 저항막 방식 터치 스크린, 일반 터치 스크린 | /res/values-port-finger (세로 모드 터치스크린에 대한 리소스 관리)
키보드 모드 | keysexposed, keyshidden, keyssoft | 사용할 수 있도록 키보드가 나타나 있음, 하드웨어 키보드가 있지만 숨겨져 있음, 소프트웨어 키보드 | /res/drawable-keysoft (소프트웨어 키보드에 대한 리소스 관리)
기본 텍스트 입력 방법  | nokeys, qwerty, 12key | 키보드 없음, 퀴티 키보드, 숫자키 키보드 | /res/values-port-notouch-12key (터치스크린이 아닌 세로 모드 화면과 숫자키 키보드에 대한 리소스 관리)
내비게이션 키 | navexposed, navhidden | 내비게이션 키 이용 가능, 내비게이션 키 이용 불가 |/res/values-port-navexposed (세로 모드 화면과 내비케이션 키 이용 가능할 때에 대한 리소스 관리) 
기본 비 터치스크린 내비게이션 방법 | nonav, dpad, trackball, wheel | 내비게이션 방법 없음, 방향 키, 트랙볼, 스크롤 휠 | /res/values-wheel (스크롤 휠 내비게이션에 대한 리소스 관리) 
플랫폼 버전 (API 레벨) | v8, v7, v4등 | 안드로이드 플랫폼 버전, 소문자 "v"을 맨 앞에 붙여야함. Android 2.2 API Level : 8 /Android 2.1 API Level : 7 | /res/values-v4 (안드로이드 플랫폼 1.6에 대한 리소스 관리) 

* 여러 가지 속성을 함께 고려해서 복잡한 멀티 리소스 관리 가능
여러 한정자를 리소스 디렉토리에 붙일 때는 앞에서 한정자들을 살펴봤던 순서대로 붙일 수 있다.

<잘못 정의된 리소스 디렉토리 이름>
/res/values-en-rUS-rGB-normal-v4 : 지역 한정자(rUS-rGB)가 두개나 정의됐다.
/res/drawable-notlong-PORT-ldpi : 한정자가 대문자(PORT)로 정의됐다.
/res/values-12key-kr : 한정자의 순서가 잘못 됐다. 기본 텍스트 입력 방법(12key)는 언어(kr) 뒤로 정의되어야 한다. 