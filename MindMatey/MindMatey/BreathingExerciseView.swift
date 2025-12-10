//
//  BreathingExerciseView.swift
//  MindMatey
//
//  Created by Vansh Jain on 03/05/25.
//
import Foundation
import SwiftUI

struct BreathingExerciseView: View {
    @State private var breathingState = BreathingState.inhale
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.3
    @State private var counter = 0
    @State private var timerRunning = false
    @State private var breathingText = "Get Ready"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    enum BreathingState {
        case inhale, hold, exhale, rest
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.5), .purple.opacity(0.5)]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // Title
                Text("Breathing Exercise")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                // Breathing circle
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 250, height: 250)
                    
                    Circle()
                        .fill(Color.white.opacity(opacity))
                        .frame(width: 230, height: 230)
                        .scaleEffect(scale)
                        .animation(.easeInOut(duration: getAnimationDuration()), value: scale)
                    
                    Text(breathingText)
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 20)
                
                // Timer display
                if timerRunning {
                    Text(counter > 0 ? "\(counter)" : "")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                } else {
                    // Start button
                    Button(action: {
                        timerRunning = true
                        breathingState = .inhale
                        updateBreathingAnimation()
                    }) {
                        Text("Begin")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.purple)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                }
                
                // Instructions
                if !timerRunning {
                    VStack(spacing: 15) {
                        Text("4-4-4-4 Breathing")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, rest for 4 seconds. Repeat.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .fixedSize(horizontal: false, vertical: true) // Ensures text wraps properly
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
                
                Spacer()
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
        }
        .onReceive(timer) { _ in
            if timerRunning {
                if counter > 0 {
                    counter -= 1
                } else {
                    updateBreathingState()
                }
            }
        }
        .navigationTitle("Breathing")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func updateBreathingState() {
        switch breathingState {
        case .inhale:
            breathingState = .hold
        case .hold:
            breathingState = .exhale
        case .exhale:
            breathingState = .rest
        case .rest:
            breathingState = .inhale
        }
        updateBreathingAnimation()
    }
    
    private func updateBreathingAnimation() {
        switch breathingState {
        case .inhale:
            breathingText = "Inhale"
            scale = 1.5
            opacity = 0.7
            counter = 4
        case .hold:
            breathingText = "Hold"
            counter = 4
        case .exhale:
            breathingText = "Exhale"
            scale = 1.0
            opacity = 0.3
            counter = 4
        case .rest:
            breathingText = "Rest"
            counter = 4
        }
    }
    
    private func getAnimationDuration() -> Double {
        switch breathingState {
        case .inhale, .exhale:
            return 4.0
        default:
            return 0.1
        }
    }
}
