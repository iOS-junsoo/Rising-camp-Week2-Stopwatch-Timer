import UIKit

class timerSecondViewController: UIViewController {
    
    public var completionHandler: ((String?) -> Void)?
    public var completionHandler1: ((String?) -> Void)?
    
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    var timeInt : Int = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //picker view를 Label에 저장
    @IBAction func didTimePickerValueChanged(_ sender : UIDatePicker){
           self.timeInt = Int(self.timePicker.countDownDuration) / 60
           
           if timeInt >= 60{
               let hour : Int = timeInt / 60
               let minit : Int = timeInt % 60
               
               if hour < 10 {
                   self.timeLabel.text = "\(hour) 시간 \(minit) 분"
               }else{
                   self.timeLabel.text = "\(hour) 시간 \(minit) 분"
               }
               
               if minit == 0{
                   if hour < 10 {
                   self.timeLabel.text = "\(hour) 시간 00 분"
               }else{
                   self.timeLabel.text = "\(hour) 시간 00 분"
               }
               }
           }else{
               self.timeLabel.text = "\(timeInt) 분"
           }
           
       }
     
    @IBAction func didTapAdd() {
        completionHandler?(field.text) //제목
        completionHandler1?(timeLabel.text) //타이머
        dismiss(animated: true, completion: nil)
    }
}




