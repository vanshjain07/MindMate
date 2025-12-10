//
//  OnboardingView.swift
//  MindMatey
//
//  Created by Vansh Jain on 03/05/25.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var isOnboardingCompleted: Bool
    @State private var userName = ""
    
    let pages = [
        OnboardingPage(
            title: "Welcome to MindMate",
            description: "Your personal companion for mental wellness and mindfulness practice",
            imageName: "brain.head.profile"
        ),
        OnboardingPage(
            title: "Track Your Mood",
            description: "Log your daily emotions and track patterns over time",
            imageName: "chart.bar.fill"
        ),
        OnboardingPage(
            title: "Guided Meditations",
            description: "Practice mindfulness with guided sessions for focus, sleep, and more",
            imageName: "waveform.path.ecg"
        ),
        OnboardingPage(
            title: "Journal Your Thoughts",
            description: "Express yourself through daily journaling to process emotions",
            imageName: "book.fill"
        )
    ]
    
    var body: some View {
        VStack {
            // Skip button
            if currentPage < pages.count {
                HStack {
                    Spacer()
                    
                    Button("Skip") {
                        withAnimation {
                            currentPage = pages.count
                        }
                    }
                    .foregroundColor(.gray)
                    .padding()
                }
            }
            
            if currentPage < pages.count {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack(spacing: 30) {
                            Image(systemName: pages[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.purple)
                                .padding(40)
                                .background(
                                    Circle()
                                        .fill(Color.purple.opacity(0.1))
                                )
                            
                            Text(pages[index].title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Text(pages[index].description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 32)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            } else {
                // User setup page (shown after swiping through all intro pages)
                VStack(spacing: 30) {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.purple)
                    
                    Text("Tell us your name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("We'll personalize your experience")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    TextField("Your name", text: $userName)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                .padding()
            }
            
            // Navigation buttons
            HStack {
                if currentPage < pages.count {
                    Button(action: {
                        withAnimation {
                            currentPage += 1
                        }
                    }) {
                        Text("Next")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 200)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {
                    Button(action: {
                        // Save user name and complete onboarding
                        UserDefaults.standard.set(userName, forKey: "userName")
                        withAnimation {
                            isOnboardingCompleted = true
                        }
                    }) {
                        Text("Get Started")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 200)
                            .padding()
                            .background(userName.isEmpty ? Color.gray : Color.purple)
                            .cornerRadius(10)
                    }
                    .disabled(userName.isEmpty)
                    .padding()
                }
            }
        }
    }
}

// Only include this struct definition once
struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
}

