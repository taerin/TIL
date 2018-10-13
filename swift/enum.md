# Enum 

``` swift 
import UIKit

enum TaerinError {
  case network
}

enum Result<T> {
  case success(T)
  case failure(TaerinError)
}

struct User {
  let Name: String
}

func foo() -> Result<User> {
  let user = User(Name: "taerin")
  
  return Result.success(user)
//  return Result.failure(TaerinError.network)
}

func goo() {
  let a = foo()
  
  switch a {
  case let .success(user):
    print(user)
  case let .failure(error):
    print(error)
  }
}

goo()

```
