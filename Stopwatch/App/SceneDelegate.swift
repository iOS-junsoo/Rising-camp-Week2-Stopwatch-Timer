//
//  SceneDelegate.swift
//  Stopwatch
//
//  Created by 준수김 on 2021/09/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   
    var window: UIWindow?
    var flag = 0
    var formatter_time1 = DateFormatter()
    var formatter_time2 = DateFormatter()
    var current_time_string1 = ""
    var current_time_string2 = ""
    var count1 = 0
    var count2 = 0
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        //print("1")
    
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
        if flag == 1 {
            //현재 출력 타입들이 모두 String(HH:mm:ss)인데 이걸 어떻게 계산할지가 문제이다.
            
            //현재 생각나는 방법 :를 기준으로 각각을 array로 바꾼다.
            //hh부분이 array[0] 이고 mm부분이 array[1]이고 ss부분이 array[2]라면
            //current_time_string2 = 3600 * array[0] + 60 * array[1] + array[2]
            //current_time_string1 = 3600 * array[0] + 60 * array[1] + array[2]
            //위처럼 계산한 뒤에 current_time_string2 - current_time_string1를 해준다.
            formatter_time1.dateFormat = "HHmmss" //현재 시분초 출력
            
            current_time_string1 = formatter_time1.string(from: Date())
            print("앱 실행 시각: \(current_time_string1)")
            count1 = Int(current_time_string1)!
            Constant.totalCount = count1 - count2
            print("앱을 나갔다가 다시 들어온 시간차이 : \(Constant.totalCount)")
            Constant.flagCount = 1
            
        }
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        formatter_time2.dateFormat = "HHmmss" //현재 시분초 출력
        
        current_time_string2 = formatter_time2.string(from: Date())
        print("앱 백그라운드 시각: \(current_time_string2)")
        count2 = Int(current_time_string2)!
        flag = 1
        Constant.flagCount = 1
        
    }
}

//https://ppomelo.tistory.com/18 참고 사이트
