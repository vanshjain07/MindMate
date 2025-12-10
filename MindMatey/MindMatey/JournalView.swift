//
//  JournalView.swift
//  MindMate
//
//  Created by Vansh Jain on 26/04/25.
//

import Foundation
import SwiftUI

struct JournalEntry: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    var mood: String
}

struct JournalView: View {
    @State private var journalEntries: [JournalEntry] = [
        JournalEntry(
            title: "Morning Reflection",
            content: "Today I'm feeling optimistic about my new project...",
            date: Date().addingTimeInterval(-86400), // yesterday
            mood: "😊"
        ),
        JournalEntry(
            title: "Afternoon Thoughts",
            content: "Had a challenging meeting today but managed to...",
            date: Date().addingTimeInterval(-172800), // 2 days ago
            mood: "😌"
        )
    ]
    
    @State private var showingNewEntry = false
    @State private var newEntryTitle = ""
    @State private var newEntryContent = ""
    @State private var newEntryMood = "😊"
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(journalEntries) { entry in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(entry.mood)
                                    .font(.title)
                                
                                VStack(alignment: .leading) {
                                    Text(entry.title)
                                        .font(.headline)
                                    
                                    Text(entry.date, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Text(entry.content)
                                .font(.body)
                                .lineLimit(2)
                                .padding(.top, 4)
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Button(action: {
                    showingNewEntry = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("New Entry")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .sheet(isPresented: $showingNewEntry) {
                NavigationView {
                    Form {
                        Section(header: Text("Mood")) {
                            HStack {
                                ForEach(["😊", "😌", "😐", "😔", "😖"], id: \.self) { emoji in
                                    Button(action: {
                                        self.newEntryMood = emoji
                                    }) {
                                        Text(emoji)
                                            .font(.system(size: 30))
                                            .padding(.horizontal, 5)
                                            .background(newEntryMood == emoji ? Color.purple.opacity(0.2) : Color.clear)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Title")) {
                            TextField("Entry title", text: $newEntryTitle)
                        }
                        
                        Section(header: Text("What's on your mind?")) {
                            TextEditor(text: $newEntryContent)
                                .frame(height: 200)
                        }
                    }
                    .navigationTitle("New Journal Entry")
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showingNewEntry = false
                        },
                        trailing: Button("Save") {
                            let newEntry = JournalEntry(
                                title: newEntryTitle,
                                content: newEntryContent,
                                date: Date(),
                                mood: newEntryMood
                            )
                            journalEntries.insert(newEntry, at: 0)
                            newEntryTitle = ""
                            newEntryContent = ""
                            showingNewEntry = false
                        }
                        .disabled(newEntryTitle.isEmpty || newEntryContent.isEmpty)
                    )
                }
            }
            .navigationTitle("Journal")
        }
    }
}
