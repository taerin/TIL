# Try with resource
Java SE 7부터 지원하는 기능으로 하나이상의 resource(프로그램이 사용 후 close 해야 하는 object)를 선언하는 try statement이다.
Statement가 끝나면 resource는 자동으로 close 된다는 것을 보장한다.

java.lang.AutoCloseable 을 구현한 객체는 try-with-resources statement 의 resource 가 될수있다.

자원을 생성하고 사용하고 해제하는 코드는 항상 다음과 같이 구조가 중복되는 코드를 작성해야 한다. finally 블록의 자원 해제 코드까지하면 더 복잡하다. 

``` java 
SomeResource resource = null;
try {
    resource = getResource();
    use(resource);
} catch(...) {
    ...
} finally {
    if (resource != null) {
        try { resource.close(); } catch(...) { /* 아무것도 안 함 */ }
    }
}
```

자바7에서 try-with-resources라는 특징이 추가되었다.  try에 자원 객체를 전달하면 finally 블록으로 종료 처리를 하지 않아도 try 코드 블록이 끝나면 자동으로 자원을 종료해주는 기능이다. 모습은 아래와 같다.

``` java
try (SomeResource resource = getResource()) {
    use(resource);
} catch(...) {
    ...
}
```

finally 블록에 출현했던 자원 해제 코드를 작성하지 않아도 되기 때문에 코딩도 편하다. try 블록에서 사용하는 자원의 개수가 늘어나면 try-with-resources의 위력은 배가 된다.

``` java
try (InputStream in = new FileInputStream(inFile);
     OutputStream out = new FileOutputStream(outFile)) {
    ...
} catch(IOException ex) {
    ...
}
// in과 out 모두 자동으로 종료됨
```

