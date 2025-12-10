import SwiftUI

struct HomeView: View {
    @State private var userName = "Friend"
    @State private var currentMood = "Neutral"
    @State private var quote = "Your mind is a garden, your thoughts are the seeds."

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hello, \(userName)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("How are you feeling today?")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "bell.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    // Mood Tracker
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Today's Mood")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(["😊", "😌", "😐", "😔", "😖"], id: \.self) { emoji in
                                    Button(action: {
                                        self.currentMood = emoji
                                        updateMoodResponse()
                                    }) {
                                        Text(emoji)
                                            .font(.system(size: 40))
                                            .frame(width: 70, height: 70)
                                            .background(
                                                Circle()
                                                    .fill(currentMood == emoji ? Color.purple.opacity(0.2) : Color.gray.opacity(0.1))
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                        }
                    }
                    .padding(.vertical, 20)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)

                    // Daily Quote
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily Inspiration")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Text("\"\(quote)\"")
                            .italic()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.3)]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 20)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)

                    // Quick Actions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                NavigationLink(destination: BreathingExerciseView()){
                                    VStack {
                                        Image(systemName: "lungs.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(.purple)
                                        Text("Breathe")
                                            .font(.caption)
                                    }
                                    .frame(width: 80, height: 80)
                                    .background(Color.purple.opacity(0.1))
                                    .cornerRadius(15)
                                }
                                
                                NavigationLink(destination: MeditationPlayerView(meditation: MeditationInfo(
                                    title: "Quick Meditation",
                                    description: "A short meditation to help you center yourself",
                                    duration: 5,
                                    backgroundColor: .blue
                                ))){
                                    VStack {
                                        Image(systemName: "brain")
                                            .font(.largeTitle)
                                            .foregroundColor(.blue)
                                        Text("Meditate")
                                            .font(.caption)
                                    }
                                    .frame(width: 80, height: 80)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(15)
                                }
                                
                                NavigationLink(destination: JournalView()){
                                    VStack {
                                        Image(systemName: "pencil")
                                            .font(.largeTitle)
                                            .foregroundColor(.orange)
                                        Text("Journal")
                                            .font(.caption)
                                    }
                                    .frame(width: 80, height: 80)
                                    .background(Color.orange.opacity(0.1))
                                    .cornerRadius(15)
                                }
                                
                                NavigationLink(destination: MentalHealthQuizView()){
                                    VStack {
                                        Image(systemName: "chart.bar.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(.red)
                                        Text("Quiz")
                                            .font(.caption)
                                    }
                                    .frame(width: 80, height: 80)
                                    .background(Color.red.opacity(0.1))
                                    .cornerRadius(15)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 20)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                    
                    // Add bottom padding for scroll space
                    Spacer()
                        .frame(height: 30)
                }
                .padding(.bottom)
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }

    // Function to update mood response
    func updateMoodResponse() {
        switch currentMood {
        case "😊":
            quote = "It's wonderful to see you happy today! Keep that positive energy flowing."
        case "😌":
            quote = "Feeling content is a beautiful state of mind. Embrace this peaceful moment."
        case "😐":
            quote = "Having a neutral day? Sometimes balance is exactly what we need."
        case "😔":
            quote = "It's okay to feel down sometimes. Consider a quick meditation or journaling session."
        case "😖":
            quote = "Difficult emotions are part of being human. Try a breathing exercise to find some relief."
        default:
            quote = "Your mind is a garden, your thoughts are the seeds."
        }
    }
}
