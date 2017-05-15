import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    var viewModel: TodoViewModel?

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.viewModel = TodoViewModel()
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Todo>>()
        self.tableView.dataSource = dataSource

        dataSource.configureCell = { dataSource, tableView, indexPath, item in
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
            
            cell.updateUI(model: item)
            return cell
        }
        
        self.viewModel!.getTodoList().bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)
        
        self.addButton.rx.tap.subscribe(onNext: {
            let todoAddView = TodoAddView()
            todoAddView.preferredContentSize = CGSize(width: 260, height: 130)
            todoAddView.modalPresentationStyle = .formSheet
            
            self.present(todoAddView, animated: true, completion: nil)
        
        }).disposed(by: self.disposeBag)    
    }
}
