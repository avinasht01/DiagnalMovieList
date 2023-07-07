//
//  AppDelegate.swift
//  Diagnal
//
//  Created by Avinash Thakur on 01/07/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerCustomFonts()
        return true
    }
    
    func registerCustomFonts() {
      let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
      fonts?.forEach { url in
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
      }
    }

    // MARK: UISceneSession Lifecycle

   

   

}

