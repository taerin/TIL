import RxSwift
import RxDataSources
import SwiftyJSON

struct TodoSection {
    var header: String
    var items: [Todo]
}

struct TodoViewModel {
    let model :TodoModel
    let disposeBag = DisposeBag()
    
    init() {
        self.model = TodoModel()
    }
    func getTodoList() -> Observable<[SectionModel<String, Todo>]>{
        return Observable.create { observer in
        
            self.model.rx_getTodoList()
                .subscribe(onNext: {(todos) in
                    let section = [SectionModel(model: "", items: todos)]
                    observer.onNext(section)
                    
                }).disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }

}
