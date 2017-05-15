import RxSwift
import RxCocoa

struct TodoAddViewModel {
    var todo = Variable<String?>("")
    var isValid: Observable<Bool> {
        return self.todo.asObservable().map { (val) -> Bool in
            return (val?.characters.count)! > 0
        }
    }
    
    let model = TodoModel()
    
    func addTodo() -> Observable<Bool>{
        return model.rx_addTodo(withTodo: self.todo.value!)
    }
}
