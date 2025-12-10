//
//  MeditationPlayerView.swift
//  MindMate
//
//  Created by Vansh Jain on 26/04/25.
//

import Foundation
import SwiftUI

struct MeditationInfo {
    let title: String
    let description: String
    let duration: Int // in minutes
    let backgroundColor: Color
}

struct MeditationPlayerView: View {
    let meditation: MeditationInfo
    
    @State private var isPlaying = false
    @State private var progress: CGFloat = 0.0
    @State private var remainingTime = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(meditation: MeditationInfo) {
        self.meditation = meditation
        _remainingTime = State(initialValue: meditation.duration * 60)
    }
    
    var body: some View {
        ZStack {
            // Background
            meditation.backgroundColor.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
                    Text(meditation.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(meditation.description)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                
                // Animated circle timer
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.1)
                        .foregroundColor(meditation.backgroundColor)
                    
                    // Progress circle
                    Circle()
                        .trim(from: 0.0, to: 1.0 - progress)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(meditation.backgroundColor)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: progress)
                    
                    // Center image
                    Image(systemName: "brain.head.profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(meditation.backgroundColor)
                        .opacity(isPlaying ? 1.0 : 0.5)
                        .scaleEffect(isPlaying ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isPlaying)
                }
                .frame(width: 250, height: 250)
                
                // Time remaining
                Text(timeFormatted(remainingTime))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .monospacedDigit()
                
                // Player controls
                HStack(spacing: 40) {
                    Button(action: {
                        // Rewind action
                        if remainingTime < meditation.duration * 60 - 15 {
                            remainingTime += 15
                            updateProgress()
                        }
                    }) {
                        Image(systemName: "gobackward.15")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(meditation.backgroundColor)
                    }
                    
                    Button(action: {
                        // Forward action
                        if remainingTime > 15 {
                            remainingTime -= 15
                            updateProgress()
                        }
                    }) {
                        Image(systemName: "goforward.15")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                
                // Bottom controls
                HStack(spacing: 30) {
                    Button(action: {
                        // Volume action
                    }) {
                        Image(systemName: "speaker.wave.2")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Background sounds
                    }) {
                        Image(systemName: "waveform")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Settings
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 20)
            }
            .padding(.vertical, 40)
        }
        .onReceive(timer) { _ in
            if isPlaying && remainingTime > 0 {
                remainingTime -= 1
                updateProgress()
            } else if remainingTime == 0 {
                isPlaying = false
            }
        }
    }
    
    private func updateProgress() {
        progress = 1.0 - (CGFloat(remainingTime) / CGFloat(meditation.duration * 60))
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
