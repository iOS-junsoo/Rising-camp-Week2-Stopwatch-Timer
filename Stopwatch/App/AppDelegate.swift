//
//  AppDelegate.swift
//  Stopwatch
//
//  Created by 준수김 on 2021/09/13.
//

//var formatter_time = DateFormatter()
//formatter_time.dateFormat = "HH:mm"
//var current_time_string = formatter_time.string(from: Date())
//print(current_time_string)

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var formatter_time = DateFormatter()
    var totalCount = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "HH시 mm분 ss초"
        var current_time_string = formatter_time.string(from: Date())
        Constant.exitText = current_time_string
        print("⚠️사용자가 어플을 강제 종료한 시각은 \(Constant.exitText)입니다.⚠️")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

