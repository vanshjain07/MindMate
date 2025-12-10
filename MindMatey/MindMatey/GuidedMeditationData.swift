//
//  GuidedMeditationData.swift
//  MindMate
//
//  Created by Vansh Jain on 28/04/25.
//

import Foundation
import Foundation
import SwiftUI

struct GuidedMeditation: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let duration: Int // in minutes
    let category: String
    let backgroundColor: Color
    let audioFileName: String
    let iconName: String
    let isPremium: Bool
}

class MeditationLibrary {
    static let shared = MeditationLibrary()
    
    var meditations: [GuidedMeditation] = [
        GuidedMeditation(
            title: "Morning Calm",
            description: "Start your day with clarity and purpose",
            duration: 10,
            category: "Focus",
            backgroundColor: .blue,
            audioFileName: "morning_meditation",
            iconName: "sun.max.fill",
            isPremium: false
        ),
        GuidedMeditation(
            title: "Stress Relief",
            description: "Release tension and find your center",
            duration: 15,
            category: "Stress",
            backgroundColor: .purple,
            audioFileName: "stress_relief",
            iconName: "leaf.fill",
            isPremium: false
        ),
        GuidedMeditation(
            title: "Deep Sleep",
            description: "Gentle guidance into restful sleep",
            duration: 20,
            category: "Sleep",
            backgroundColor: .indigo,
            audioFileName: "sleep_meditation",
            iconName: "moon.stars.fill",
            isPremium: false
        ),
        GuidedMeditation(
            title: "Anxiety Calm",
            description: "Techniques to quiet anxious thoughts",
            duration: 12,
            category: "Anxiety",
            backgroundColor: .green,
            audioFileName: "anxiety_calm",
            iconName: "heart.circle",
            isPremium: false
        ),
        GuidedMeditation(
            title: "Focus Builder",
            description: "Sharpen your mind and improve concentration",
            duration: 8,
            category: "Focus",
            backgroundColor: .blue,
            audioFileName: "focus_meditation",
            iconName: "brain.head.profile",
            isPremium: true
        ),
        GuidedMeditation(
            title: "Evening Wind Down",
            description: "Transition from day to night peacefully",
            duration: 15,
            category: "Sleep",
            backgroundColor: .indigo,
            audioFileName: "evening_meditation",
            iconName: "sunset.fill",
            isPremium: true
        )
    ]
    
    func getMeditations(for category: String) -> [GuidedMeditation] {
        return meditations.filter { $0.category == category }
    }
    
    func getAllCategories() -> [String] {
        return Array(Set(meditations.map { $0.category }))
    }
}
