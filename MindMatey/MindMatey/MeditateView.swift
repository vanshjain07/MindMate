//
//  MeditateView.swift
//  MindMatey
//
//  Created by Vansh Jain on 03/05/25.
//

import Foundation
import SwiftUI

struct MeditateView: View {
    @State private var selectedCategory: String = "All"
    private var categories: [String] {
        ["All"] + MeditationLibrary.shared.getAllCategories()
    }
    
    private var filteredMeditations: [GuidedMeditation] {
        if selectedCategory == "All" {
            return MeditationLibrary.shared.meditations
        } else {
            return MeditationLibrary.shared.getMeditations(for: selectedCategory)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Featured session
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 200)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Featured Session")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text("Mindful Morning")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("10 minutes • Voice guided")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                            
                            NavigationLink(destination: MeditationPlayerView(meditation:
                                MeditationInfo(
                                    title: "Mindful Morning",
                                    description: "Start your day with clarity and intention",
                                    duration: 10,
                                    backgroundColor: .purple
                                )
                            )) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("Begin")
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .foregroundColor(.purple)
                                .cornerRadius(20)
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Categories
                    Text("Categories")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    VStack {
                                        Image(systemName: categoryIcon(for: category))
                                            .font(.largeTitle)
                                            .foregroundColor(categoryColor(for: category))
                                            .frame(width: 70, height: 70)
                                            .background(categoryColor(for: category).opacity(0.1))
                                            .clipShape(Circle())
                                        
                                        Text(category)
                                            .font(.headline)
                                        
                                        Text(categoryDescription(for: category))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .frame(width: 120)
                                    .padding()
                                    .background(selectedCategory == category ? categoryColor(for: category).opacity(0.2) : Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Meditation list
                    Text(selectedCategory == "All" ? "All Meditations" : "\(selectedCategory) Meditations")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    ForEach(filteredMeditations) { meditation in
                        NavigationLink(destination: MeditationPlayerView(meditation:
                            MeditationInfo(
                                title: meditation.title,
                                description: meditation.description,
                                duration: meditation.duration,
                                backgroundColor: meditation.backgroundColor
                            )
                        )) {
                            HStack {
                                Image(systemName: meditation.iconName)
                                    .font(.title2)
                                    .foregroundColor(meditation.backgroundColor)
                                    .frame(width: 50, height: 50)
                                    .background(meditation.backgroundColor.opacity(0.1))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(meditation.title)
                                            .font(.headline)
                                        
                                        if meditation.isPremium {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                                .font(.caption)
                                        }
                                    }
                                    
                                    Text("\(meditation.duration) min • \(meditation.category)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "play.circle")
                                    .font(.title2)
                                    .foregroundColor(meditation.backgroundColor)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
            .navigationTitle("Meditate")
        }
    }
    
    private func categoryIcon(for category: String) -> String {
        switch category {
        case "Focus": return "brain.head.profile"
        case "Sleep": return "moon.stars.fill"
        case "Anxiety": return "heart.circle"
        case "Stress": return "leaf.fill"
        default: return "rectangle.grid.2x2"
        }
    }
    
    private func categoryColor(for category: String) -> Color {
        switch category {
        case "Focus": return .blue
        case "Sleep": return .indigo
        case "Anxiety": return .purple
        case "Stress": return .green
        default: return .gray
        }
    }
    
    private func categoryDescription(for category: String) -> String {
        switch category {
        case "Focus": return "Improve concentration"
        case "Sleep": return "Better rest"
        case "Anxiety": return "Calm your mind"
        case "Stress": return "Release tension"
        case "All": return "All sessions"
        default: return ""
        }
    }
}

