import Foundation
import SwiftyJSON
import FirebaseDatabase
import RxSwift

struct TodoModel {
    let ref:FIRDatabaseReference
    
    init() {
        self.ref = FIRDatabase.database().reference(withPath: "/todo")
    }
    
    func rx_getTodoList() -> Observable<[Todo]> {
        return Observable.create({ (observer) -> Disposable in
            let listRef = self.ref
            let handle = listRef.observe(.value, with: { (snapshot) in
                let todos = snapshot.children.flatMap {
                    ($0 as? FIRDataSnapshot)?.value as? [String: Any]
                    }.map {
                        Todo(json: JSON($0))
                }
                
                observer.onNext(todos)
            })
            
            return Disposables.create {
                listRef.removeObserver(withHandle: handle)
            }
        })
    }
    
    func rx_addTodo(withTodo todo: String) -> Observable<Bool>{
        let newRef = self.ref.childByAutoId()
        var error: Error?
        
        newRef.setValue(["todo": todo, "status": false, "key": newRef.key]) { err, _ in
            if let err = err {
                error = err
            }
        }
        
        return Observable.create({ (observer) -> Disposable in
            if error != nil {
                observer.onNext(false)
            } else{
                observer.onNext(true)
            }
            
            return Disposables.create()
        })
    }
    
}

struct Todo {
    let todo: String
    let status: Bool
    let key: String
    
    init(json: JSON) {
        self.todo = json["todo"].stringValue
        self.status = json["status"].boolValue
        self.key = json["key"].stringValue
    }
}
