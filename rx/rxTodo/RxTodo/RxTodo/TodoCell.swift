import UIKit
import FirebaseDatabase

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    var key: String?
    private var ref: FIRDatabaseReference!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if let key = self.key {
            self.ref = FIRDatabase.database().reference(withPath: "/todo/" + key + "/status/")
            self.ref.setValue(self.statusSwitch.isOn)
        }
    }
    
    func updateUI(model: Todo) {
        self.statusSwitch.isOn = model.status
        self.todoLabel.text = model.todo
        self.key = model.key
    }
}
