//
//  TC2007B_ExamenApp.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import SwiftUI

@main
struct TC2007B_ExamenApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            CovidView()
        }.onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("App State : Background")
            case .inactive:
                print("App State : Inactive")
            case .active: // Foreground
                print("App State : Active")
            @unknown default:
                print("App State : Unknown")
            }
        }
    }
}
