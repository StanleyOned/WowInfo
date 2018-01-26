//
//  AppDelegate.swift
//  WowInfo
//
//  Created by Stanley Delacruz on 1/24/18.
//  Copyright © 2018 Stanley Delacruz. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = .white
        }
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: PvPViewController(collectionViewLayout: layout))
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black ]
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().isTranslucent = false 
        return true
    }
}

