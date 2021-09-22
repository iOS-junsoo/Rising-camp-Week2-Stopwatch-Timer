//스톱워치 VC
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetLapButton: UIButton!
    @IBOutlet weak var lap1: UILabel!
    @IBOutlet weak var lap2: UILabel!
    @IBOutlet weak var lap3: UILabel!
    @IBOutlet weak var lap4: UILabel!
    @IBOutlet weak var lap5: UILabel!
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var lapCount:Int = 1 //다음 랩으로 넘어가게 만든 변수
    var falg = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            resetLapButton.setImage(UIImage(named: "reset.png"), for: .normal)
            //버튼을 누르면 resetLapButton의 이미지를 reset으로 바꾼다.
            self.count = 0 //상승하는 count를 다시 0으로 설정
            self.timer.invalidate() //타이머를 중지하는 timer.invalidate()호출 invalidate: 무효화, 타이머가 다시 실행되는 것을 중지하고 런 루프에서 제거를 요청
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setImage(UIImage(named: "start.png"), for: .normal)
            //버튼을 누르면 resetLapButton의 이미지를 start으로 바꾼다.
            self.lap1.text = " "
            self.lap2.text = " "
            self.lap3.text = " "
            self.lap4.text = " "
            self.lap5.text = " "
            self.lapCount = 1
        print("flag1: \(falg)")
        if falg == 1 {
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                // 뷰 객체 얻어오기 (storyboard ID로 ViewController구분)
                guard let uvc = storyboard?.instantiateViewController(identifier: "welcomeVC") else {
                    return
                }
                
                // 화면 전환 애니메이션 설정
                uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
                self.present(uvc, animated: true)
            falg = 0
            print("flag2: \(falg)")
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if count > 0 {
        let alert2 = UIAlertController(title: "※주의※", message: "이대로 화면을 나가면 스톱워치가 멈추게 됩니다. 계속하시겠습니까?", preferredStyle: .actionSheet)
        alert2.addAction(UIAlertAction(title: "계속하기", style: .cancel, handler: { (_) in //재설정 취소버튼
            self.timer.invalidate() //화면을 나가면 타이머가 멈춤.
        }))
        alert2.addAction(UIAlertAction(title: "돌아가기", style: .default, handler: { (_) in
            self.tabBarController?.selectedIndex = 2
        }))
        self.present(alert2, animated: true, completion: nil)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if count > 0 {
        let alert2 = UIAlertController(title: "🏃🏼‍♂️이어하기🏃🏼‍♂️", message: "이전에 실행했던 타이머가 이미 있습니다. 이어서 하시겠습니까?", preferredStyle: .actionSheet)
        alert2.addAction(UIAlertAction(title: "다시하기", style: .cancel, handler: { (_) in //재설정 취소버튼
            self.count = 0 //상승하는 count를 다시 0으로 설정
            self.timer.invalidate() //타이머를 중지하는 timer.invalidate()호출 invalidate: 무효화, 타이머가 다시 실행되는 것을 중지하고 런 루프에서 제거를 요청
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setImage(UIImage(named: "start.png"), for: .normal)
            //버튼을 누르면 resetLapButton의 이미지를 start으로 바꾼다.
            self.lap1.text = " "
            self.lap2.text = " "
            self.lap3.text = " "
            self.lap4.text = " "
            self.lap5.text = " "
            self.lapCount = 1
        }))
            alert2.addAction(UIAlertAction(title: "이어하기", style: .default, handler: { [self] (_) in
            if(self.timerCounting) //타이머가 시간을 계산중이라면
                    {
                self.resetLapButton.setImage(UIImage(named: "reset.png"), for: .normal)
                //버튼을 누르면 resetLapButton의 이미지를 reset으로 바꾼다.
                self.timerCounting = false //timerCounting은 false
                self.timer.invalidate() //사용자가 startStop버튼을 탭하면 타이머를 중지하는 timer.invalidate()호출
                self.startStopButton.setImage(UIImage(named: "start.png"), for: .normal)
                //버튼을 누르면 startStopButton의 이미지를 start으로 바꾼다.
                    }else //타이머가 시간을 계산중이 아니라면
                    {
                        self.resetLapButton.setImage(UIImage(named: "lap.png"), for: .normal)
                        //버튼을 누르면 resetLapButton의 이미지를 lap으로 바꾼다.
                        self.timerCounting = true //timerCounting은 true
                        self.startStopButton.setImage(UIImage(named: "stop.png"), for: .normal)
                        //버튼을 누르면 resetLapButton의 이미지를 stop으로 바꾼다.
                        timer = Timer.scheduledTimer(timeInterval: 0.0157, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                        //scheduledTimer: 타이머를 만들고 기본모드의 현재 실행 루프에서 타이머를 예약합니다.
                        //timeInterval:타이머 실행 간격 - 0.0157초 / target: 함수 selector가 호출되어야 하는 클래스 인스턴스 - 자신 / selector:  타이머가 실행될 때 호출 할 함수, / userInfo : selector 에게 제공되는 데이터가 있는 dictionary / repeats : 참일 경우 타이머는 무효화될 때까지 반복적으로 다시 예약, 거짓일 경우 타이머가 실행된 후 타이머가 무효화
                    }
        }))
        self.present(alert2, animated: true, completion: nil)
        }
    }
    @IBAction func resetTapped(_ sender: UIButton) {
        if(timerCounting) {//타이머가 시간을 계산중이라면 랩
            lapCount += 1
            print(lapCount)
        } else { //타이머가 시간을 계산중이 아니라면 재설정
            resetLapButton.setImage(UIImage(named: "reset.png"), for: .normal)
            //버튼을 누르면 resetLapButton의 이미지를 reset으로 바꾼다.
            let alert = UIAlertController(title: "[타이머 재설정]", message: "타이머를 재설정 하시겠습니까?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in //재설정 취소버튼
            //do nothing
            }))
            alert.addAction(UIAlertAction(title: "재설정", style: .default, handler: { (_) in //재설정 수락버튼 default: 기본값
                self.count = 0 //상승하는 count를 다시 0으로 설정
                self.timer.invalidate() //타이머를 중지하는 timer.invalidate()호출 invalidate: 무효화, 타이머가 다시 실행되는 것을 중지하고 런 루프에서 제거를 요청
                self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
                self.startStopButton.setImage(UIImage(named: "start.png"), for: .normal)
                //버튼을 누르면 resetLapButton의 이미지를 start으로 바꾼다.
                self.lap1.text = " "
                self.lap2.text = " "
                self.lap3.text = " "
                self.lap4.text = " "
                self.lap5.text = " "
                self.lapCount = 1
            }))
            
            self.present(alert, animated: true, completion: nil)
            //alert 현재 뷰 컨트롤러의 콘텐츠 위에 표시할 것
            //animated: true : 애니메이션 ㄲ
            //completion: nil : 프레젠테이션이 완료된 후 실행할 블럭은 없다(nil).
            
        }
        
    }
    @IBAction func startStopTapped(_ sender: UIButton) {
        if(timerCounting) //타이머가 시간을 계산중이라면
                {
            resetLapButton.setImage(UIImage(named: "reset.png"), for: .normal)
            //버튼을 누르면 resetLapButton의 이미지를 reset으로 바꾼다.
                    timerCounting = false //timerCounting은 false
                    timer.invalidate() //사용자가 startStop버튼을 탭하면 타이머를 중지하는 timer.invalidate()호출
            startStopButton.setImage(UIImage(named: "start.png"), for: .normal)
            //버튼을 누르면 startStopButton의 이미지를 start으로 바꾼다.
                }else //타이머가 시간을 계산중이 아니라면
                {
                    resetLapButton.setImage(UIImage(named: "lap.png"), for: .normal)
                    //버튼을 누르면 resetLapButton의 이미지를 lap으로 바꾼다.
                    timerCounting = true //timerCounting은 true
                    startStopButton.setImage(UIImage(named: "stop.png"), for: .normal)
                    //버튼을 누르면 resetLapButton의 이미지를 stop으로 바꾼다.
                    timer = Timer.scheduledTimer(timeInterval: 0.0157, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                    //scheduledTimer: 타이머를 만들고 기본모드의 현재 실행 루프에서 타이머를 예약합니다.
                    //timeInterval:타이머 실행 간격 - 0.0157초 / target: 함수 selector가 호출되어야 하는 클래스 인스턴스 - 자신 / selector:  타이머가 실행될 때 호출 할 함수, / userInfo : selector 에게 제공되는 데이터가 있는 dictionary / repeats : 참일 경우 타이머는 무효화될 때까지 반복적으로 다시 예약, 거짓일 경우 타이머가 실행된 후 타이머가 무효화
                }
    }
    @objc func timerCounter() -> Void
        {
            count = count + 1 //이 함수가 호출될 때마다 count + 1
            let time = secondsToHoursMinutesSeconds(seconds: count) //증가하는 count 값을 secondsToHoursMinutesSeconds함수에 넣고 출력값을 time에 저장
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2) //makeTimeString함수에 time의 첫번째 값을 hours, 두번째 값을 minutes, 세번째 값을 seconds에 넣는다.
            TimerLabel.text = timeString //위에서 선언한 TimerLabel의 text 값에 timerString을 넣어준다.
        
        // 랩을 만들어주는 부분 - 랩은 7까지 가면 다시 1로 돌아온다.
        switch lapCount % 5 {
        case 1:
            lap1.text = "랩 1                                                 " + timeString //위에서 선언한 랩1의 text 값에 timerString을 넣어준다.
        case 2:
            lap2.text = "랩 2                                                " + timeString //위에서 선언한 랩1의 text 값에 timerString을 넣어준다.
        case 3:
            lap3.text = "랩 3                                                " + timeString //위에서 선언한 랩1의 text 값에 timerString을 넣어준다.
        case 4:
            lap4.text = "랩 4                                                " + timeString //위에서 선언한 랩1의 text 값에 timerString을 넣어준다.
        case 0:
            lap5.text = "랩 5                                                " + timeString //위에서 선언한 랩1의 text 값에 timerString을 넣어준다.
        default:
            print("error")
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
            timeString += " . "
            timeString += String(format: "%02d", seconds)
            return timeString //timeString의 형태 ->hours : minutes : seconds
        }
}

