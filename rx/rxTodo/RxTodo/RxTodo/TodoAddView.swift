import UIKit
import RxSwift
import RxCocoa

class TodoAddView: UIViewController {
    var onComplete:((String) -> Void)?
    
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = TodoAddViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.todoTextField.rx.text.orEmpty.bind(to: self.viewModel.todo).disposed(by:self.disposeBag)
        self.viewModel.isValid.map { $0 }.bind(to: self.completeButton.rx.isEnabled).disposed(by: self.disposeBag)
        
        self.completeButton.rx.tap
            .flatMap { _ -> Observable<Bool> in
                return self.viewModel.addTodo()
            }
            .subscribe(onNext: { result in
                if result == true {
                    print("업데이트 성공")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("업데이트 실패")
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }    
}
