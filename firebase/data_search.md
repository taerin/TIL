# 데이터 검색
Firebase 실시간 데이터베이스에 저장된 데이터를 검색하려면 데이터베이스 참조에 비동기 리스너를 연결합니다. 리스너는 데이터의 초기 상태가 확인될 때 한 번 호출된 후 데이터가 변경될 때마다 다시 호출됩니다. 이 문서에서는 데이터베이스 데이터 검색의 기초와 함께 데이터의 순서 및 간단한 데이터 쿼리를 실행하는 방법을 설명합니다.

## 시작하기
Firebase 데이터베이스에서 데이터를 읽는 방법을 알아보기 위해 앞 문서의 블로깅 예제를 다시 살펴보겠습니다.
게시물 데이터를 읽으려면 다음을 수행합니다.

``` javascript
// Get a database reference to our posts
var db = firebase.database();
var ref = db.ref("server/saving-data/fireblog/posts");

// Attach an asynchronous callback to read the data at our posts reference
ref.on("value", function(snapshot) {
console.log(snapshot.val());
}, function (errorObject) {
console.log("The read failed: " + errorObject.code);
});
```

* 이벤트 구독 시 선택사항으로 읽기가 취소될 때 호출되는 취소 콜백을 전달할 수 있습니다. 예를 들어 앱 클라이언트에 데이터베이스 참조에서 데이터를 읽을 권한이 없으면 읽기가 취소됩니다. 이 콜백에는 실패 이유를 나타내는 error 개체가 전달됩니다.

이 코드를 실행하면 모든 게시물을 포함하는 개체가 콘솔에 로깅됩니다. 이 함수는 데이터베이스 참조에 데이터가 새로 추가될 때마다 호출되며, 이 기능을 구현하기 위해 별도의 코드를 작성할 필요가 없습니다.

콜백 함수는 데이터의 스냅샷인 __ DataSnapshot __ 을 수신합니다. 스냅샷은 단일 시점에 특정 데이터베이스 참조에 있던 데이터를 촬영한 사진과 같습니다. 스냅샷에 대해 val() / getValue()를 호출하면 데이터의 JavaScript 개체 표현이 반환됩니다. 참조 위치에 데이터가 없으면 스냅샷 값은 null입니다.

위 예제에서 사용한 value 이벤트 유형은 데이터 중 극히 일부가 변경되어도 Firebase 데이터베이스 참조의 전체 내용을 읽습니다. value는 데이터베이스에서 데이터를 읽는 데 사용할 수 있는 아래에서 설명할 5가지 이벤트 유형 중 하나입니다.

## 읽기 이벤트 유형
### 값
value 이벤트는 읽기 이벤트 발생 시점에 특정 데이터베이스 경로에 있던 내용의 정적 스냅샷을 읽는 데 사용됩니다. 이 이벤트는 초기 데이터가 확인될 때 한 번 발생한 후 데이터가 변경될 때마다 발생합니다. 하위 데이터를 포함하여 해당 위치의 모든 데이터를 포함하는 스냅샷이 이벤트 콜백에 전달됩니다. 위 코드 예제에서 value는 앱의 모든 블로그 게시물을 반환했습니다. 블로그 게시물이 새로 추가될 때마다 콜백 함수가 모든 게시물을 반환합니다.

### 하위추가
child_added 이벤트는 일반적으로 데이터베이스에서 항목 목록을 검색하는 데 사용됩니다. 위치의 전체 내용을 반환하는 value와 달리 child_added는 기존 하위 항목마다 한 번씩 발생한 후 지정된 경로에 하위 항목이 새로 추가될 때마다 다시 발생합니다. 새 하위 항목의 데이터를 포함하는 스냅샷이 이벤트 콜백에 전달됩니다. 정렬을 위해 이전 하위 항목의 키를 포함하는 두 번째 인수도 전달됩니다.

블로깅 앱에 추가되는 새 게시물 각각의 데이터만 검색하려면 child_added를 사용합니다.

``` javascript
// Retrieve new posts as they are added to our database
ref.on("child_added", function(snapshot, prevChildKey) {
  var newPost = snapshot.val();
  console.log("Author: " + newPost.author);
  console.log("Title: " + newPost.title);
  console.log("Previous Post ID: " + prevChildKey);
});
```

이 예제에서 스냅샷은 개별 블로그 게시물 개체를 포함합니다. 값을 검색하여 게시물을 개체로 변환했으므로 각각 author 및 title을 호출하여 게시물의 작성자 및 제목 속성에 액세스할 수 있습니다. 또한 두 번째 prevChildKey 인수를 통해 이전 게시물 ID에 액세스할 수 있습니다.

### 하위 변경

child_changed 이벤트는 하위 노드가 수정될 때마다 발생합니다. 여기에는 하위 노드의 하위에 대한 수정이 포함됩니다. 이 이벤트는 일반적으로 child_added 및 child_removed와 함께 항목 목록의 변경에 대응하는 데 사용됩니다. 이벤트 콜백에 전달되는 스냅샷에는 하위 항목의 업데이트된 데이터가 포함됩니다.

child_changed를 사용하여 블로그 게시물이 수정될 때 업데이트된 데이터를 읽을 수 있습니다.

``` javasript
// Get the data on a post that has changed
ref.on("child_changed", function(snapshot) {
  var changedPost = snapshot.val();
  console.log("The updated post title is " + changedPost.title);
});
```

### 하위 삭제
child_removed 이벤트는 바로 아래 하위 항목이 삭제될 때 발생합니다. 이 이벤트는 일반적으로 child_added 및 child_changed와 함께 사용됩니다. 이벤트 콜백에 전달되는 스냅샷에는 삭제된 하위 항목의 데이터가 포함됩니다.

블로그 예제에서는 child_removed를 사용하여 삭제된 게시물에 대한 알림을 콘솔에 로깅합니다.

``` javascript
// Get a reference to our posts
var ref = db.ref("server/saving-data/fireblog/posts");

// Get the data on a post that has been removed
ref.on("child_removed", function(snapshot) {
  var deletedPost = snapshot.val();
  console.log("The blog post titled '" + deletedPost.title + "' has been deleted");
});
```

### 이벤트 보증

Firebase 데이터베이스는 이벤트와 관련하여 몇 가지 중요한 사항을 보증합니다.

#### 데이터베이스 이벤트 보증
1) 로컬 상태가 변경되면 항상 이벤트가 발생합니다.
2) 네트워크 연결이 잠시 끊길 때와 같이 로컬 작업 또는 타이밍으로 인해 일시적인 차이가 발생하더라도 이벤트는 결과적으로 항상 데이터의 올바른 상태를 반영합니다.
3) 단일 클라이언트의 쓰기 작업은 항상 서버에 기록된 후에 다른 사용자에게 전파됩니다.
4) 값 이벤트는 항상 마지막에 발생하며, 스냅샷이 생성되기 전에 발생한 모든 기타 이벤트의 업데이트를 항상 포함합니다.

값 이벤트는 항상 마지막에 발생하므로 다음 예제는 항상 정상적으로 작동합니다.

``` javascript
var count = 0;

ref.on("child_added", function(snap) {
  count++;
  console.log("added:", snap.key);
});

// length will always equal count, since snap.val() will include every child_added event
// triggered before this point
ref.once("value", function(snap) {
  console.log("initial data loaded!", snap.numChildren() === count);
});
```

## 콜백 분리
콜백을 삭제하려면 다음과 같이 이벤트 유형 및 삭제할 콜백 함수를 지정합니다.

``` javascript
ref.off("value", originalCallback);
```

on()에 범위 컨텍스트를 전달한 경우 콜백을 분리할 때에도 전달해야 합니다.


``` javascript
ref.off("value", originalCallback, this);
```

* 한 데이터 위치에 콜백을 여러 번 추가하면 경우 이벤트가 발생할 때마다 콜백이 여러 번 호출되며, 콜백을 완전히 삭제하려면 여러 번 분리해야 합니다.
특정 위치의 모든 콜백을 삭제하려면 다음을 수행합니다.

``` javascript
// Remove all value callbacks
ref.off("value");

// Remove all callbacks of any type
ref.off();
```
## 데이터 한 번 읽기

한 번만 호출되고 즉시 삭제되는 콜백이 유용한 경우가 있습니다. 편의를 위해 다음과 같은 헬퍼 함수를 만들었습니다.

``` javascript
ref.once("value", function(data) {
  // do some stuff once
});
```

## 데이터 쿼리
Firebase 데이터베이스 쿼리를 사용하여 다양한 요소를 기준으로 데이터를 선택적으로 검색할 수 있습니다. 데이터베이스 쿼리를 작성하려면 우선 정렬 함수(orderByChild(), orderByKey(), orderByValue()) 중 하나를 사용하여 데이터 정렬 방식을 지정합니다. 그런 다음 5가지 기타 메소드(limitToFirst(), limitToLast(), startAt(), endAt() 및 equalTo())와 조합하여 복잡한 쿼리를 실행할 수 있습니다.

공룡을 좋아하는 Firebase 개발팀의 취향에 따라 공룡 자료 데이터베이스를 사용하여 데이터 필터링 방법을 시연하고자 합니다. 공룡 데이터의 일부는 다음과 같습니다.

``` javascript
{
  "lambeosaurus": {
    "height" : 2.1,
    "length" : 12.5,
    "weight": 5000
  },
  "stegosaurus": {
    "height" : 4,
    "length" : 9,
    "weight" : 2500
  }
}
```
데이터를 정렬할 수 있는 3가지 기준은 하위 키, 키 또는 값입니다. 기본적인 데이터베이스 쿼리는 이러한 정렬 함수 중 하나로 시작되며, 아래에서 이러한 함수를 각각 설명합니다.

### 지정된 하위 키로 정렬
공통 하위 키를 orderByChild()에 전달하여 해당 키로 노드를 정렬할 수 있습니다. 예를 들어 모든 공룡을 키에 따라 정렬하여 읽으려면 다음을 수행합니다.

``` javascript
var db = firebase.database();
var ref = db.ref("dinosaurs");
ref.orderByChild("height").on("child_added", function(snapshot) {
  console.log(snapshot.key + " was " + snapshot.val().height + " meters tall");
});
```

쿼리 대상인 하위 키가 없는 노드는 null 값을 기준으로 정렬되어 가장 먼저 나오게 됩니다. 데이터 정렬 방식에 대한 자세한 내용은 데이터의 순서 섹션을 참조하세요.

바로 아래 수준의 하위 항목뿐 아니라 깊이 중첩된 하위 항목을 기준으로 정렬할 수도 있습니다. 아래와 같이 데이터가 깊이 중첩된 경우 이 기능이 유용합니다.

``` javascript
{
  "lambeosaurus": {
    "dimensions": {
      "height" : 2.1,
      "length" : 12.5,
      "weight": 5000
    }
  },
  "stegosaurus": {
    "dimensions": {
      "height" : 4,
      "length" : 9,
      "weight" : 2500
    }
  }
}
```
이러한 경우 키를 쿼리하려면 단일 키가 아닌 개체에 대한 전체 경로를 사용합니다.

``` javascript
var ref = db.ref("dinosaurs");
ref.orderByChild("dimensions/height").on("child_added", function(snapshot) {
  console.log(snapshot.key + " was " + snapshot.val().height + " meters tall");
});
```

쿼리에서 한 번에 하나의 키로만 정렬할 수 있습니다. 한 쿼리에서 orderByChild()를 여러 번 호출하면 오류가 발생합니다.

* 성능 향상을 위해 색인 사용
프로덕션 앱에서 orderByChild()를 사용하려면 보안 및 Firebase 규칙의 .indexOn 규칙을 통해 색인을 생성할 키를 정의해야 합니다. 클라이언트에서 임시로 이러한 쿼리를 작성할 수도 있지만 .indexOn을 사용하면 성능이 크게 향상됩니다. .indexOn 규칙에 대한 자세한 내용은 문서를 참조하세요.


### Ordering by key
orderByKey() 메소드를 사용하여 키를 기준으로 노드를 정렬할 수도 있습니다. 다음 예제에서는 모든 공룡을 알파벳 순으로 읽습니다.

``` javascript
var ref = db.ref("dinosaurs");
ref.orderByKey().on("child_added", function(snapshot) {
  console.log(snapshot.key);
});
```
### 값으로 정렬
orderByValue() 메소드를 사용하여 하위 키 값을 기준으로 노드를 정렬할 수 있습니다. 공룡들이 운동경기를 펼친 결과 점수를 다음과 같은 형식으로 기록한다고 가정해 보겠습니다.

``` javascript
{
  "scores": {
    "bruhathkayosaurus" : 55,
    "lambeosaurus" : 21,
    "linhenykus" : 80,
    "pterodactyl" : 93,
    "stegosaurus" : 5,
    "triceratops" : 22
  }
}
```
공룡들을 점수에 따라 정렬하려면 다음과 같은 쿼리를 작성합니다.
``` javascript
var scoresRef = db.ref("scores");
scoresRef.orderByValue().on("value", function(snapshot) {
  snapshot.forEach(function(data) {
    console.log("The " + data.key + " dinosaur's score is " + data.val());
  });
});
```

orderByValue()를 사용할 때 null, 부울, 문자열 및 개체 값이 정렬되는 방식에 대한 설명은 데이터의 순서 섹션을 참조하세요.

* 성능 향상을 위해 값 색인 생성
프로덕션 앱에서 orderByValue()를 사용하려면 규칙에서 해당 색인에 .value를 추가해야 합니다. .indexOn 규칙에 대한 자세한 내용은 문서를 참조하세요.

## 복잡한 쿼리

이제 데이터 정렬 방법을 지정했으므로 아래와 같이 제한 또는 범위 메소드를 사용하여 더욱 복잡한 쿼리를 작성할 수 있습니다.

### 제한 쿼리
limitToFirst() 및 limitToLast() 쿼리를 사용하여 특정 콜백에서 동기화할 하위 항목의 최대 개수를 설정합니다. 제한을 100개로 설정하면 처음에 최대 100개의 child_added 이벤트만 수신합니다. 데이터베이스에 저장된 메시지가 100개 미만이면 각 메시지에 대해 child_added 이벤트가 발생합니다. 그러나 메시지가 100개를 넘는 경우 메시지 중 100개에 대한 child_added 이벤트만 수신됩니다. limitToFirst()를 사용하는 경우 정렬된 처음 100개의 메시지가, limitToLast()를 사용하는 경우 정렬된 마지막 100개의 메시지가 수신됩니다. 항목이 변경됨에 따라 쿼리에 새로 포함되는 항목에 대해 child_added 이벤트, 쿼리에서 제외되는 항목에 대해 child_removed 이벤트가 수신되며 총 개수는 100개로 유지됩니다.

공룡 자료 데이터베이스와 orderByChild()를 사용하여 가장 무거운 두 공룡을 찾아낼 수 있습니다.

``` javascript
var ref = db.ref("dinosaurs");
ref.orderByChild("weight").limitToLast(2).on("child_added", function(snapshot) {
  console.log(snapshot.key);
});
```
데이터베이스에 저장된 공룡이 둘 이상이라면 child_added 콜백은 정확히 두 번 호출됩니다. 또한 데이터베이스에 더 무거운 공룡이 새로 추가될 때마다 호출됩니다.

마찬가지로 limitToFirst()를 사용하여 키가 가장 작은 두 공룡을 찾아낼 수 있습니다.

``` javascript
var ref = db.ref("dinosaurs");
ref.orderByChild("height").limitToFirst(2).on("child_added", function(snapshot) {
  console.log(snapshot.key);
});
```
데이터베이스에 저장된 공룡이 둘 이상이라면 child_added 콜백은 정확히 두 번 호출됩니다. 처음 두 공룡 중 하나가 데이터베이스에서 삭제되면 새 공룡이 해당 위치를 차지하므로 콜백이 다시 호출됩니다.

orderByValue()로 제한 쿼리를 실행할 수도 있습니다. 공룡 운동경기 점수 1, 2, 3위를 포함하는 리더보드를 만들려면 다음 쿼리를 실행합니다.

``` javascript
var scoresRef = db.ref("scores");
scoresRef.orderByValue().limitToLast(3).on("value", function(snapshot) {
  snapshot.forEach(function(data) {
    console.log("The " + data.key + " dinosaur's score is " + data.val());
  });
});
```

### 범위 쿼리
startAt(), endAt() 및 equalTo()를 사용하여 쿼리의 시작 및 종료 지점을 임의로 선택할 수 있습니다. 예를 들어 키가 3미터 이상인 공룡을 모두 검색하려면 orderByChild()와 startAt()을 조합합니다.

``` javascript
var ref = db.ref("dinosaurs");
  ref.orderByChild("height").startAt(3).on("child_added", function(snapshot) {
    console.log(snapshot.key);
  });

```

endAt()을 사용하여 이름이 사전순으로 Pterodactyl보다 먼저 나오는 공룡을 모두 찾을 수 있습니다.

``` javscript
var ref = db.ref("dinosaurs");
ref.orderByKey().endAt("pterodactyl").on("child_added", function(snapshot) {
  console.log(snapshot.key);
});
```

* startAt()과 endAt()은 경계를 포함합니다. 즉, 'pterodactyl'도 위 쿼리와 일치합니다.

startAt()과 endAt()을 조합하여 쿼리의 양단을 모두 제한할 수 있습니다. 다음 예제에서는 이름이 'b'로 시작되는 공룡을 모두 검색합니다.

``` javascript
var ref = db.ref("dinosaurs");
ref.orderByKey().startAt("b").endAt("b\uf8ff").on("child_added", function(snapshot) {
  console.log(snapshot.key);
});
```

* 위 쿼리에 사용된 \uf8ff 문자는 유니코드 범위에서 매우 높은 코드 포인트입니다. 이 문자는 유니코드에서 대부분의 정규 문자보다 뒤에 나오므로 쿼리는 b로 시작되는 모든 값과 일치합니다.

equalTo() 메소드로 정확히 일치하는 항목을 필터링할 수 있습니다. 다른 범위 쿼리와 마찬가지로 일치하는 각 하위 노드마다 콜백이 호출됩니다. 예를 들어 다음 쿼리를 사용하여 키가 25미터인 공룡을 모두 찾을 수 있습니다.

``` javascript
var ref = db.ref("dinosaurs");
ref.orderByChild("height").equalTo(25).on("child_added", function(snapshot) {
  console.log(snapshot.key);
});
```
범위 쿼리는 데이터를 페이지화하는 경우에도 유용합니다.

* orderByValue()과 startAt() 및 endAt()을 조합하여 범위 쿼리를 작성할 수도 있습니다.

### 하나로 결합

이러한 기법을 모두 조합하여 복잡한 쿼리를 만들 수 있습니다. 예를 들어 스테고사우르스보다 키가 작은 공룡의 이름을 검색할 수 있습니다.

``` javascript
var ref = db.ref("dinosaurs");
ref.child("stegosaurus").child("height").on("value", function(stegosaurusHeightSnapshot) {
  var favoriteDinoHeight = stegosaurusHeightSnapshot.val();

  var queryRef = ref.orderByChild("height").endAt(favoriteDinoHeight).limitToLast(2)
  queryRef.on("value", function(querySnapshot) {
    if (querySnapshot.numChildren() === 2) {
      // Data is ordered by increasing height, so we want the first entry
      querySnapshot.forEach(function(dinoSnapshot) {
        console.log("The dinosaur just shorter than the stegasaurus is " + dinoSnapshot.key);

        // Returning true means that we will only loop through the forEach() one time
        return true;
      });
    } else {
      console.log("The stegosaurus is the shortest dino");
    }
  });
});
```

## 데이터의 순서
이 섹션에서는 4가지 정렬 함수를 사용할 때 데이터가 정렬되는 방식을 각각 설명합니다.

### orderByChild

orderByChild()를 사용하면 지정된 하위 키를 포함하는 데이터가 다음과 같이 정렬됩니다.

지정된 하위 키의 값이 null인 하위 항목이 맨 처음에 옵니다.
지정된 하위 키의 값이 false인 하위 항목이 그 다음에 옵니다. 값이 false인 하위 항목이 여러 개이면 키에 따라 사전순으로 정렬됩니다.
지정된 하위 키의 값이 true인 하위 항목이 그 다음에 옵니다. 값이 true인 하위 항목이 여러 개이면 키에 따라 사전순으로 정렬됩니다.
숫자 값을 갖는 하위 항목이 다음에 나오며 오름차순으로 정렬됩니다. 지정된 하위 노드의 숫자 값이 동일한 하위 항목이 여러 개이면 키에 따라 정렬됩니다.
숫자 다음에는 문자열이 나오며 사전순, 오름차순으로 정렬됩니다. 지정된 하위 노드의 값이 동일한 하위 항목이 여러 개이면 키에 따라 사전순으로 정렬됩니다.
마지막으로 개체가 나오며 키에 따라 사전순, 오름차순으로 정렬됩니다.

### orderByKey

orderByKey()를 사용하여 데이터를 정렬하는 경우 다음과 같이 데이터가 키에 따라 오름차순으로 반환됩니다. 키는 항상 문자열입니다.

키가 32비트 정수로 파싱될 수 있는 하위 항목이 맨 처음에 나오며 오름차순으로 정렬됩니다.
키가 문자열 값인 하위 항목이 다음에 나오며 사전순, 오름차순으로 정렬됩니다.

### orderByValue

orderByValue()를 사용하면 하위 항목이 값에 따라 정렬됩니다. 정렬 기준은 orderByChild()와 동일하며, 지정된 하위 키의 값 대신 노드의 값이 사용된다는 점이 다릅니다

[출처] https://firebase.google.com/docs/database/server/retrieve-data




