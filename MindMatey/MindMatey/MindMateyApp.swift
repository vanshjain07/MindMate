//
//  MindMateApp.swift
//  MindMate
//
//  Created by Vansh Jain on 26/04/25.
//

import SwiftUI

@main
struct MindMateApp: App {
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted = false
    
    var body: some Scene {
        WindowGroup {
            if isOnboardingCompleted {
                ContentView()
            } else {
                OnboardingView(isOnboardingCompleted: $isOnboardingCompleted)
            }
        }
    }
}

