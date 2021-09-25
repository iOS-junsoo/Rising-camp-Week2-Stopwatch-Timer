import UIKit
var tray = ""
var space = " - "
class timerfirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text: String = self.data[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "[Custom timer]"
    }
    //<편집>
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            // 왼쪽에 만들기
        
        let like = UIContextualAction(style: .normal, title: "Edit") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                self.data[0] = self.textField.text! + space + tray
                self.textField.text = ""
                self.timeLabel.text = ""
                tray = ""
                self.tableView.reloadSections(IndexSet(0...0), with: UITableView.RowAnimation.automatic)
                
                success(true)
            }
            like.backgroundColor = .systemTeal
        return UISwipeActionsConfiguration(actions:[like])
    }
    
    //<삭제>
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
           if editingStyle == .delete {
               
               data.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
               
           } else if editingStyle == .insert {
               
           }
       }
    
    @IBOutlet weak var tableView: UITableView!
    let collIdentifier: String = "cell"
    var data: [String] = []
    
    @IBOutlet weak var textField: UITextField!
    
    //<생성>
    @IBAction func touchAddButton(_ sender: UIButton) {
        data.append(String(textField.text! + space + tray))
        self.textField.text = ""
        self.timeLabel.text = ""
        tray = ""
        //print(data)
        self.tableView.reloadSections(IndexSet(0...0), with: UITableView.RowAnimation.automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    var timeInt : Int = Int()
    @IBAction func didTimePickerValueChanged(_ sender : UIDatePicker){
           self.timeInt = Int(self.timePicker.countDownDuration) / 60
           
           if timeInt >= 60{
               let hour : Int = timeInt / 60
               let minit : Int = timeInt % 60
               
               if hour < 10 {
                   tray = "\(hour) 시간 \(minit) 분"
                   self.timeLabel.text = "\(hour) 시간 \(minit) 분"
               }else{
                   tray = "\(hour) 시간 \(minit) 분"
                   self.timeLabel.text = "\(hour) 시간 \(minit) 분"
               }
               
               if minit == 0{
                   if hour < 10 {
                       tray = "\(hour) 시간 00 분"
                       self.timeLabel.text = "\(hour) 시간 00 분"
               }else{
                   tray = "\(hour) 시간 00 분"
                   self.timeLabel.text = "\(hour) 시간 00 분"
               }
               }
           }else{
               tray = "\(timeInt) 분"
               self.timeLabel.text = "\(timeInt) 분"
           }
           
       }
    


}
