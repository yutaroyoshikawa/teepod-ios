//
//  AppDelegate.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/15.
//  Copyright © 2020 TeePod. All rights reserved.
//

import BackgroundTasks
import CoreData
import UIKit
import Moya

class PrintOperation: Operation {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    override func main() {
        print("this operation id is \(id)")
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let modeCheck = ModeCheck()
    private let api = MoyaProvider<TeePodAPI>()
    
    private func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.TeePod.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    private func searchIsLaunch() -> Bool? {
        let value = UserDefaults.standard.object(forKey: "is_launch")
        guard let is_launch = value as? Bool else {
            return nil
        }
        return is_launch
    }
    
    private func setIsLaunch(isLaunch: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(isLaunch, forKey: "is_launch")
        userDefaults.synchronize()
    }
    
    private func getIsLaunch() -> Bool {
        let isLaunch = searchIsLaunch()
        
        if isLaunch != nil {
            return isLaunch!
        }
        
        setIsLaunch(isLaunch: false)
        return getIsLaunch()
    }
    
    private func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
        let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
        
            task.expirationHandler = {
                queue.cancelAllOperations()
            }
        
            let operation = PrintOperation(id: 1)
            operation.completionBlock = {
                task.setTaskCompleted(success: operation.isFinished)
            }
        
        let isLaunch = getIsLaunch()
        
        if (isLaunch) {
            let paripiTime = modeCheck.getParipiTime()
            let mode = modeCheck.judgeMode(paripi_time: paripiTime)
            api.request(TeePodAPI.changeColor(color: mode.rawValue)) { _ in
                queue.addOperation(operation)
            }
        } else {
            queue.addOperation(operation)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            fatalError("Not found: '.env'.\nPlease create .env file reference from .env.sample")
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8) ?? "Empty File"
            let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
            let envVars = clean.components(separatedBy: "\n")
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy: "=")
                if keyVal.count == 2 {
                    setenv(keyVal[0], keyVal[1], 1)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.TeePod.refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // バックグラウンド起動に移ったときにルケジューリング登録
        scheduleAppRefresh()
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
          The persistent container for the application. This implementation
          creates and returns a container, having loaded the store for the
          application to it. This property is optional since there are legitimate
          error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TeePod")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
