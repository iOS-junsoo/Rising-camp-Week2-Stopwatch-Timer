import UIKit

class timerfirstViewController: UIViewController {

    var count = -1
    
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var labelTime0: UILabel!
    @IBOutlet weak var labelTime1: UILabel!
    @IBOutlet weak var labelTime2: UILabel!
    @IBOutlet weak var labelTime3: UILabel!
    @IBOutlet weak var labelTime4: UILabel!
    @IBOutlet weak var labelTime5: UILabel!
    @IBOutlet weak var labelTime6: UILabel!
    @IBOutlet weak var labelTime7: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "SecondVC") as! timerSecondViewController
        vc.modalPresentationStyle = .fullScreen
        //Titel을 나타내는 Label
        vc.completionHandler = { text in
            switch self.count {
            case 0:
                self.label0.text = text
            case 1:
                self.label1.text = text
            case 2:
                self.label2.text = text
            case 3:
                self.label3.text = text
            case 4:
                self.label4.text = text
            case 5:
                self.label5.text = text
            case 6:
                self.label6.text = text
            case 7:
                self.label7.text = text
            default:
                print("errer")
            }
//            self.label\(count).text = text
        }
        
        //Time을 나타내는 Label
        vc.completionHandler1 = { text in
            switch self.count {
            case 0:
                self.labelTime0.text = text
            case 1:
                self.labelTime1.text = text
            case 2:
                self.labelTime2.text = text
            case 3:
                self.labelTime3.text = text
            case 4:
                self.labelTime4.text = text
            case 5:
                self.labelTime5.text = text
            case 6:
                self.labelTime6.text = text
            case 7:
                self.labelTime7.text = text
            default:
                print("errer")
            }
//            self.label\(count).text = text
        }
        present(vc, animated: true)
        
        count += 1
    }
    

}
