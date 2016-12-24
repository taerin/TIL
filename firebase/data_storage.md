#  서버 설치 및 설정
이 문서에서는 Firebase 실시간 데이터베이스에 데이터를 쓰는 4가지 방식인 설정, 업데이트, 푸시, 트랜잭션 기능에 대해 설명합니다.

## 데이터 저장 방법

방법| 내용
----|------
설정 | 정의된 경로(예: messages/users/<username>)에 데이터를 쓰거나 대체합니다.
업데이트 | 정의된 경로에서 모든 데이터를 대체하지 않고 일부 키를 업데이트합니다.
푸시 | 데이터베이스의 데이터 목록에 추가합니다. 목록에 새 노드를 푸시할 때마다 데이터베이스에서 고유 키(예: messages/users/<unique-user-id>/<username>)를 생성합니다.
트랜잭션 | 동시 업데이트에 의해 손상될 수 있는 복잡한 데이터를 다루는 경우 트랜잭션 기능을 사용합니다.

## 데이터 저장
기본 데이터베이스 쓰기 작업은 지정된 데이터베이스 참조에 새 데이터를 저장하고 해당 경로의 기존 데이터를 모두 대체하는 set입니다. 
set 이해를 위한 간단한 블로깅 앱 예. 앱의 데이터는 아래와 같은 데이터베이스 참조에 저장됩니다.

``` javascript
var db = firebase.database();
var ref = db.ref("server/saving-data/fireblog");
```

### 사용자 데이터 저장
고유한 사용자 이름을 기준으로 각 사용자를 저장하고 전체이름과 생일을 함께 저장하려 합니다.
각 사용자는 고유한 사용자 이름을 가지므로 별도의 키를 만들 필요가 없기 때문에 push 메소드 대신 set 메소드를 사용하는 것이 이치에 맞다.

	=> __ push 메소드는 별도의 키를 만들면서 저장할 때 유용 __

우선 사용자 데이터를 가리키는 데이터 베이스 참조를 만듭니다(ref). 그런다음 set(), setValue() 로 데이터베이스에 사용자 이름, 전체 이름 및 생일과 함께 사용자 개체를 저장합니다. 문자열, 숫자, 부울, null, 배열 또는 임의의 JSON 개체를 저장할 수 있습니다. 
	=> __ null을 전달하면 지정된 위치에서 데이터가 삭제됩니다.__

	
``` javascript
	var usersRef = ref.child("users");
	usersRef.set({
		alanisawesome: {
			date_of_birth: "June 23, 1912",
			full_name: "Alan Turing"
		},
		gracehop: {
			date_of_birth: "December 9, 1906",
		full_name: "Grace Hopper"
		}	
	});
```

JSON 개체가 데이터베이스에 저장될 때 개체 속성은 중첩된 형태로 데이터베이스 하위 위치에 자동으로 매핑됩니다. 

``` javascript
{
	"users": {
		"alanisawesome": {
			"date_of_birth": "June 23, 1912",
				"full_name": "Alan Turing"
		},
			"gracehop": {
				"date_of_birth": "December 9, 1906",
				"full_name": "Grace Hopper"
			}
	}
}

```

하위 데이터에 직접 저장할 수도 있습니다.

``` javascript 
usersRef.child("alanisawesome").set({
	date_of_birth: "June 23, 1912",
	full_name: "Alan Turing"
	});
usersRef.child("gracehop").set({
	date_of_birth: "December 9, 1906",
	full_name: "Grace Hopper"
	});
```

위의 두 예제, 즉 개체 하나로 두 값을 한 번에 쓰는 예제와 하위 위치에 별도로 값을 쓰는 예제가 데이터베이스에 저장하는 데이터는 결과적으로 동일합니다.

__ 첫 번째 예제에서는 데이터를 감시하는 클라이언트에서 이벤트가 한번 발생하는 반면 두 번째 예제에서는 이벤트가 두 번 발생합니다. __
주의할 점은 userRef 에 이미 데이터가 있는 경우 첫 번째 방식에서는 데이터를 덮어쓰지만, 두번째 방식에서는 하위 노드 각각의 값만 수정되며 userRef의 다른 하위 노드는 바뀌지 않는다는 점입니다.

=> __ 값을 설정하면 지정된 위치에서 하위 노드를 포함하여 모든 데이터를 덮어씁니다. __

## 저장된 데이터 업데이트
데이터베이스 위치에서 다른 하위노드를 덮어쓰지 않고 여러 하위 노드에 동시에 쓰려면 아래와 같이 update 메소드를 사용합니다.

``` javascript
var hopperRef = usersRef.child("gracehop");
hopperRef.update({
		"nickname": "Amazing Grace"
		});
```
이렇게 하면 Grace의 데이터가 업데이트되어 별명이 포함됩니다. 여기에서 update 대신 set를 사용했다면 hopperRef에서 full_name 및 date_of_birth가 삭제되었을 것입니다.

Firebase 실시간 데이터베이스는 다중 경로 업데이트도 지원합니다. 다시 말해 update로 데이터베이스의 여러 위치에서 동시에 값을 업데이트 할 수 있으며, 이 기능은 데이터 비정규화에 큰 도움이 됩니다.  다중 경로 업데이트를 사용하여 Alan과 Grace의 별명을 동시에 추가할 수 있습니다.

``` javascript
usersRef.update({
		"alanisawesome/nickname": "Alan The Machine",
		"gracehop/nickname": "Amazing Grace"
		});
```

이 업데이트에 따라 Alan과 Grace의 별명이 추가되었습니다.

``` javascript
{
	"users": {
		"alanisawesome": {
			"date_of_birth": "June 23, 1912",
				"full_name": "Alan Turing",
				"nickname": "Alan The Machine"
		},
			"gracehop": {
				"date_of_birth": "December 9, 1906",
				"full_name": "Grace Hopper",
				"nickname": "Amazing Grace"
			}
	}
}
```
경로가 포함된 개체를 기록하여 개체를 업데이트하려고 하면 동작이 달라집니다. Grace와 Alan을 다음과 같은 방법으로 업데이트하면 어떻게 되는지 살펴보겠습니다.

``` javascript
usersRef.update({
	"alanisawesome": {
		"nickname": "Alan The Machine"
	},
	"gracehop": {
		"nickname": "Amazing Grace"
	}
});
```
이렇게 하면 동작이 달라져서 전체 /users 노드를 덮어쓰게 됩니다.

```javascript
{
	"users": {
		"alanisawesome": {
			"nickname": "Alan The Machine"
		},
			"gracehop": {
				"nickname": "Amazing Grace"
			}
	}
}
```

### 중첩 데이터 업데이트
alanisawesome과 같은 단일 키 경로에서는 첫 번째 하위 수준의 데이터만 업데이트되고, 그보다 더 하위 수준에 전달되는 데이터는 set 작업으로 간주됩니다. 다중 경로 동작에서는 alanisawesome/nickname과 같이 더욱 긴 경로를 사용해도 데이터를 덮어쓰지 않습니다. 이로 인해 첫 번째 예제와 두 번째 예제의 동작이 달라집니다.

## 완료 콜백 추가
데이터가 커밋되는 시점을 파악하려면 완료 콜백을 추가합니다. set 및 update는 선택사항으로 완료 콜백을 취하며 쓰기가 데이터베이스에 커밋되면 이 콜백이 호출됩니다. 특정한 이유로 호출이 실패하면 실패 이유를 나타내는 오류개체가 전달됩니다.

``` javascript
dataRef.set("I'm writing data", function(error) {
	if (error) {
		alert("Data could not be saved." + error);
	} else {
		alert("Data saved successfully.");
	}
});
```

## 데이터 목록 저장
데이터 목록을 만들 때는 대부분의 애플리케이션은 여러 사용자를 관리해야 한다는 점을 염두해 두고 목록 구조를 적절히 조정해야 합니다.
이제 위 예제를 확장하여 앱에 블로그 게시물을 추가해보겠습니다. 다음과 같이 자동으로 증가하는 정수 색인과 함께 set를 사용하여 하위 항목을 저장하는 방법이 가장 먼저 떠오르실 지도 모릅니다.

``` javascript
// NOT RECOMMENDED - use push() instead!
{
	"posts": {
		"0": {
			"author": "gracehop",
				"title": "Announcing COBOL, a New Programming Language"
		},
		"1": {
			"author": "alanisawesome",
			"title": "The Turing Machine"
		}
	}
}
```

### 푸시와 트랜잭션 비교
데이터 목록을 다룰 때 push()는 고유한 시간순 키를 보장합니다. 트랜잭션을 대신 사용하여 자체 키를 생성하는 방법도 있겠지만, 푸시가 훨씬 더 나은 방법입니다. 트랜잭션은 속도가 느리고 더욱 복잡하며, 서버와 1회 이상의 라운드트립*을 거쳐야 합니다. 클라이언트에서 `push()`로 생성한 키는 오프라인에서도 작동하고 성능이 최적화됩니다.

* 라운드 트립이란? 메시지를 원격지에 보내고 그것이 돌아오기까지의 경과 시간

사용자가 새 게시물을 추가하면 /posts/2로 저장됩니다. 게시자가 1명이면 문제가 없지만, 수많은 사용자가 접속하는 블로깅 애플리케이션에서는 여러 사용자가 동시에 게시물을 추가할 수 있습니다. 두 명의 사용자가 동시에 /posts/2에 기록하면 한 쪽 게시물이 다른 한 쪽을 삭제합니다. 
이 문제를 해결하기 위해 Firebase 클라이언트는 새 하위 항목의 고유 키를 생성하는 push() 함수를 제공합니다. 고유 하위 키를 사용하면 여러 클라이언트가 동시에 같은 위치에 하위 항목을 추가해도 쓰기 충돌이 발생할 우려가 없습니다.

``` javascript
var postsRef = ref.child("posts");

var newPostRef = postsRef.push();
newPostRef.set({
	  author: "gracehop",
      title: "Announcing COBOL, a New Programming Language"
});

// we can also chain the two calls together
postsRef.push().set({
	  author: "alanisawesome",
      title: "The Turing Machine"
});
```

고유 키는 타임 스탬프에 기초하므로 목록 항목은 시간순으로 자동 정렬됩니다. 각 블로그 게시물에 대해 고유키가 생성되므로 여러 사용자가 동시에 게시물을 추가해도 쓰기 충돌이 발생하지 않습니다. 이제 데이터베이스의 데이터는 다음과 같습니다.

``` javascript
{
	"posts": {
		"-JRHTHaIs-jNPLXOQivY": {
			"author": "gracehop",
			"title": "Announcing COBOL, a New Programming Language"
		},
		"-JRHTHaKuITFIhnj02kE": {
			"author": "alanisawesome",
			"title": "The Turing Machine"
		}
	}
}
```
JavaScript에서는 push()와 set()을 연달아 호출하는 패턴이 흔히 나타나므로, 다음과 같이 두 메소드를 결합하여 설정할 데이터를 push()에 직접 전달하는 기능을 구현했습니다.

``` javascript
// This is equivalent to the calls to push().set(...) above
postsRef.push({
	  author: "gracehop",
	    title: "Announcing COBOL, a New Programming Language"
});
```

## push()가 생성한 고유 키 가져오기
push()를 호출하면 새 데이터 경로에 대한 참조가 반환되고, 이 참조로 키를 가져오거나 데이터를 설정할 수 있습니다. 다음 코드는 위 예제와 동일한 데이터를 산출하지만 이제 생성된 고유 키에 액세스할 수 있습니다.

``` javascript 
// Generate a reference to a new location and add some data using push()
var newPostRef = postsRef.push();

// Get the unique key generated by push()
var postId = newPostRef.key;
```

위와 같이 push() 참조에서 고유 키 값을 가져올 수 있습니다.

## 트랜잭션 데이터 저장
증가 카운터와 같이 동시 수정으로 인해 손상될 수 있는 복잡한 데이터를 다루는 경우를 위해 트랜잭션 작업이 제공됩니다. 이 작업에 두 가지 콜백, 즉 업데이트 함수 및 선택적 완료 콜백을 지정할 수 있습니다.
업데이트 함수는 데이터의 현재 상태를 인수로 취하고 이 데이터에 새로 기록하려는 값을 반환합니다. 예를 들어 특정 블로그 게시물의 추천 수를 증가시키려는 경우 다음과 같은 트랜잭션을 작성할 수 있습니다.

``` javascript
var upvotesRef = db.ref("server/saving-data/fireblog/posts/-JRHTHaIs-jNPLXOQivY/upvotes");
upvotesRef.transaction(function (current_value) {
	  return (current_value || 0) + 1;
});

```

기본값이 기록되지 않은 null 상태에서 트랜잭션이 호출될 수도 있으므로 카운터가 null이거나 아직 증가되지 않았는지를 확인해야 합니다.
트랜잭션 함수 없이 위 코드를 실행하면 두 클라이언트에서 동시에 값을 증가시키려고 할 때 두 경우 모두 새 값으로 1이 기록되어 결과적으로 2가 아닌 1만 증가합니다.

### 여러 번 호출되는 트랜잭션 함수

트랜잭션 핸들러는 여러 번 호출되므로 null 데이터를 처리할 수 있어야 합니다. 데이터베이스에 기존 데이터가 있더라도 트랜잭션 함수가 실행될 때 로컬에 캐시된 데이터가 없을 수도 있습니다.

## 네트워크 연결 및 오프라인 쓰기
클라이언트의 네트워크 연결이 끊겨도 앱은 계속 정상적으로 작동합니다.

모든 Firebase 클라이언트는 자체적으로 활성 데이터의 내부 버전을 유지합니다. 데이터를 쓰면 우선 로컬 버전에 기록됩니다. 그런 다음 클라이언트가 해당 데이터를 데이터베이스 및 다른 클라이언트와 '최선을 다해' 동기화합니다.

이와 같이 데이터베이스에 대한 모든 쓰기 작업은 로컬 이벤트를 즉시 발생시키며, 그 이후에 데이터베이스에 데이터가 기록됩니다. 따라서 Firebase를 사용하여 애플리케이션을 개발하면 네트워크 지연 시간 또는 인터넷 연결 여부에 관계없이 앱이 응답성을 유지합니다.

네트워크에 다시 연결되면 해당 이벤트 세트가 수신되어 클라이언트가 현재 서버 상태를 따라잡으므로 맞춤 코드를 별도로 작성할 필요가 없습니다.















