import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            MeditateView()
                .tabItem {
                    Label("Meditate", systemImage: "brain.head.profile")
                }
            ChatbotView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }
            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "book.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.purple) // Theme color
    }
}
