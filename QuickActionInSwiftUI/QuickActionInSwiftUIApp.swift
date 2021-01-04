//
//  QuickActionInSwiftUIApp.swift
//  QuickActionInSwiftUI
//
//  Created by ramil on 04.01.2021.
//

import SwiftUI

@main
struct QuickActionInSwiftUIApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let quickActionObservable = QuickActionObservable()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quickActionObservable)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .active:
                print("App is active")
                guard let type = shortcutItemProcess?.userInfo?["type"] as? String else {
                    return
                }
                quickActionObservable.selectedAction = getAction(type)
                print(type)
                
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is background")
                var shortcutItems = UIApplication.shared.shortcutItems ?? []
                if shortcutItems.isEmpty {
                    for action in allDynamicActions {
                        shortcutItems.append(action.quickAction())
                    }
                } else {
                    shortcutItems[0] = ActionType.DynamicThree.instance.quickAction()
                }
                UIApplication.shared.shortcutItems = shortcutItems
                
            @unknown default:
                print("default - unexpected val")
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if let shortcutItem = options.shortcutItem {
            shortcutItemProcess = shortcutItem
        }
        
        let sceneConfigaration = UISceneConfiguration(name: "Custom Configaration", sessionRole: connectingSceneSession.role)
        sceneConfigaration.delegateClass = CustomSceneDelegate.self
        
        return sceneConfigaration
    }
}

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        shortcutItemProcess = shortcutItem
    }
}

var shortcutItemProcess: UIApplicationShortcutItem?
