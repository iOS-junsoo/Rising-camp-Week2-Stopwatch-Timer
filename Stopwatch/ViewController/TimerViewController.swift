//타이머 VC

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var reset: UIButton!
    let shapeLayer = CAShapeLayer()
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var labelHour:Int = 0
    var labelMin:Int = 0
    var labelSec:Int = 0
    var timeMin = 60
    var timeSec = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start.setTitleColor(UIColor.green, for: .normal)
        reset.setTitleColor(UIColor.gray, for: .normal)
        reset.setTitle("RESET", for: .normal)
        reset.setTitleColor(UIColor.gray, for: .normal)
        self.count = 0
        self.timer.invalidate()
        self.label.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        self.start.setTitle("START", for: .normal)
        self.start.setTitleColor(UIColor.green, for: .normal)
        // let's start by drawing a circle somehow
        
        let center = view.center
        
        // create my track layer
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        //
        trackLayer.path = circularPath.cgPath //경로 선언
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 15
    
        
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 15
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0 //원 진행률 시작점
        view.layer.addSublayer(shapeLayer)
        
    }
    @IBAction func startClick(_ sender: UIButton) {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            
        }else{
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd") //keypath = 0
        
        basicAnimation.toValue = 1 //수신기가 보간법을 끝내는 데 사용하는 값을 정의
        
        basicAnimation.duration = CFTimeInterval(Double(count) + Double(count) * 0.27) //애니메이션의 기본 지속 시간(초)을 지정
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        }
        
    }
    @IBAction func resetClick(_ sender: UIButton) {
        reset.setTitle("RESET", for: .normal)
        reset.setTitleColor(UIColor.gray, for: .normal)
        self.count = 0
        self.timer.invalidate()
        self.label.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        self.start.setTitle("START", for: .normal)
        self.start.setTitleColor(UIColor.green, for: .normal)
        labelHour = 0
        labelMin = 0
        labelSec = 0
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd") //keypath = 0
        
        basicAnimation.toValue = 1 //수신기가 보간법을 끝내는 데 사용하는 값을 정의
        
        basicAnimation.duration = 0 //애니메이션의 기본 지속 시간(초)을 지정
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    @objc func timerCounter() -> Void  {
        if count > 0 {
            count = count - 1 //이 함수가 호출될 때마다 count - 1
            let time = secondsToHoursMinutesSeconds(seconds: count) //증가하는 count 값을 secondsToHoursMinutesSeconds함수에 넣고 출력값을 time에 저장
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2) //makeTimeString함수에 time의 첫번째 값을 hours, 두번째 값을 minutes, 세번째 값을 seconds에 넣는다.
            label.text = timeString //위에서 선언한 TimerLabel의 text 값에 timerString을 넣어준다.
          //print(count)
        }
         else {
            timerCounting = false
            timer.invalidate()
            start.setTitle("START", for: .normal)
            start.setTitleColor(UIColor.green, for: .normal)
            labelHour = 0
            labelMin = 0
            labelSec = 0
             let alert4 = UIAlertController(title: "⏰타이머⏰", message: "타이머가 종료되었습니다.", preferredStyle: .alert)
             
             alert4.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { (_) in //재설정 취소버튼
             //do nothing
             }))
             
             
             
             self.present(alert4, animated: true, completion: nil)
        }
            
        }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) //초에서 시간 : 분 : 초로 바꾸어주는 함수
        {
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60)) //다음과 같은 연산으로 초를 이용해서 시간, 분, 초를 출력
        }
        
        func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String //위에서 만든 시간, 분, 초를 문자열 형태의 디티절 시간으로 출력
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString //timeString의 형태 ->hours : minutes : seconds
        }
    
   
    // MARK: PLUSBUTTON
    @IBAction func plusHour(_ sender: UIButton) { //시간 + 버튼을 눌렀을 때
        count += 3600
        labelHour += 1
        self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
    }
    
    @IBAction func plusMin(_ sender: UIButton) { //분 + 버튼을 눌렀을 때
        count += 60
        if labelMin < 59 {
            labelMin += 1
            self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
        } else {
        labelHour += 1
        labelMin = 0
        self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
        }
    }
    @IBAction func plusSec(_ sender: UIButton) { //초 + 버튼을 눌렀을 때
        count += 1
        if labelSec < 59 {
        labelSec += 1
        self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
        } else {
            labelMin += 1
            labelSec = 0
            self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
        }
    }
    
    // MARK: MINUSBUTTON
    @IBAction func minusHour(_ sender: UIButton) { //시간 - 버튼을 눌렀을 때
        
        if count > 3599 {
        count -= 3600
        labelHour -= 1
        self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
        }
    }
    @IBAction func minusMin(_ sender: UIButton) { //분 - 버튼을 눌렀을 때
        if count > 59 {
        count -= 60
            if labelMin > 0 {
        labelMin -= 1
        self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
            }else {
                labelHour -= 1
                labelMin = timeMin - 1
                self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
            }
        }
    }
    @IBAction func minusSec(_ sender: UIButton) { //초 - 버튼을 눌렀을 때
        if count > 0 {
        count -= 1
            if labelSec > 0 {
        labelSec -= 1
        self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
            } else {
                labelMin -= 1
                labelSec = timeSec - 1
                self.label.text = self.makeTimeString(hours: labelHour, minutes: labelMin, seconds: labelSec)
            }
        }
    }

}
