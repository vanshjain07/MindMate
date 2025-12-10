//
//  ProfileView.swift
//  MindMate
//
//  Created by Vansh Jain on 26/04/25.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var userName = "Alex"
    @State private var userImage = "person.circle.fill"
    @State private var streakDays = 7
    @State private var totalMeditations = 23
    @State private var totalJournals = 15
    @State private var totalMinutes = 128
    
    @State private var remindersEnabled = true
    @State private var reminderTime = Date()
    @State private var darkModeEnabled = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Profile header
                    VStack {
                        Image(systemName: userImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.purple)
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .clipShape(Circle())
                        
                        Text(userName)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Mindfulness Journey: Level 2")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Edit profile action
                        }) {
                            Text("Edit Profile")
                                .font(.caption)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                        }
                        .padding(.top, 5)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    // Stats
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Stats")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 15) {
                            StatCard(value: "\(streakDays)", title: "Day Streak", icon: "flame.fill", color: .orange)
                            StatCard(value: "\(totalMeditations)", title: "Meditations", icon: "brain", color: .purple)
                        }
                        
                        HStack(spacing: 15) {
                            StatCard(value: "\(totalJournals)", title: "Journal Entries", icon: "book.fill", color: .blue)
                            StatCard(value: "\(totalMinutes)", title: "Minutes", icon: "clock.fill", color: .green)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Settings
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Settings")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            Toggle("Daily Reminders", isOn: $remindersEnabled)
                                .padding()
                                .background(Color.white)
                            
                            Divider()
                            
                            if remindersEnabled {
                                DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                    .padding()
                                    .background(Color.white)
                                
                                Divider()
                            }
                            
                            Toggle("Dark Mode", isOn: $darkModeEnabled)
                                .padding()
                                .background(Color.white)
                            
                            Divider()
                            
                            NavigationLink(destination: Text("Notifications Settings")) {
                                HStack {
                                    Text("Notifications")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                            }
                        }
                        .cornerRadius(15)
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                    
                    // About & Help
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About & Help")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            NavigationLink(destination: Text("About MindMate")) {
                                HStack {
                                    Text("About MindMate")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                            }
                            
                            Divider()
                            
                            NavigationLink(destination: Text("Help & Support")) {
                                HStack {
                                    Text("Help & Support")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                            }
                            
                            Divider()
                            
                            Button(action: {
                                // Terms action
                            }) {
                                HStack {
                                    Text("Terms & Privacy")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                            }
                        }
                        .cornerRadius(15)
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
            .navigationTitle("Profile")
        }
    }
}

struct StatCard: View {
    var value: String
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}
