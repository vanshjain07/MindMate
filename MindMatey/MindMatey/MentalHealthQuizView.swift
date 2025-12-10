import Foundation
import SwiftUI

struct Question {
    let text: String
    let options: [String]
    let scores: [Int]
}

struct MentalHealthQuizView: View {
    let questions = [
        Question(
            text: "How often do you feel overwhelmed by your responsibilities?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores (was [0, 1, 2, 3, 4])
        ),
        Question(
            text: "How would you rate your sleep quality in the past week?",
            options: ["Excellent", "Good", "Fair", "Poor", "Very poor"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you feel sad or down?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you engage in activities you enjoy?",
            options: ["Daily", "Several times a week", "Weekly", "Rarely", "Almost never"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How would you rate your ability to focus on tasks?",
            options: ["Excellent", "Good", "Fair", "Poor", "Very poor"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you experience physical symptoms of stress (headaches, tension, etc.)?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How connected do you feel to your friends and family?",
            options: ["Very connected", "Connected", "Somewhat connected", "Slightly connected", "Not connected"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you feel worried or anxious?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How satisfied are you with your work-life balance?",
            options: ["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you have difficulty relaxing?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How would you rate your overall energy levels?",
            options: ["Excellent", "Good", "Fair", "Poor", "Very poor"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you feel irritable or easily annoyed?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you engage in physical exercise?",
            options: ["Daily", "Several times a week", "Weekly", "Rarely", "Almost never"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you have trouble with negative thoughts?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How satisfied are you with your relationships?",
            options: ["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you feel hopeful about the future?",
            options: ["Almost always", "Often", "Sometimes", "Occasionally", "Rarely or never"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How would you rate your ability to manage stress?",
            options: ["Excellent", "Good", "Fair", "Poor", "Very poor"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you take time to practice mindfulness or relaxation?",
            options: ["Daily", "Several times a week", "Weekly", "Rarely", "Almost never"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "How often do you feel overwhelmed by your emotions?",
            options: ["Rarely or never", "Occasionally", "Sometimes", "Often", "Almost always"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        ),
        Question(
            text: "Overall, how would you rate your mental wellbeing right now?",
            options: ["Excellent", "Good", "Fair", "Poor", "Very poor"],
            scores: [4, 3, 2, 1, 0] // Reversed scores
        )
    ]

    @State private var currentQuestionIndex = 0
    @State private var selectedOptions: [Int?] = Array(repeating: nil, count: 20)
    @State private var showResults = false
    @State private var totalScore = 0
    @State private var scoreOutOf10 = 0.0

    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.5), .purple.opacity(0.5)]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                if showResults {
                    resultsView
                } else {
                    questionView
                }
            }
            .padding()
            .background(Color.white.opacity(0.95))
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
        .navigationTitle("Mental Health Assessment")
    }

    var questionView: some View {
        VStack(spacing: 20) {
            // Progress indicator
            HStack {
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                Spacer()
                Text("\(Int((Float(currentQuestionIndex) / Float(questions.count)) * 100))%")
            }
            .foregroundColor(.gray)
            .padding(.top, 8)

            // Progress bar
            ProgressView(value: Float(currentQuestionIndex) / Float(questions.count))
                .accentColor(.purple)

            // Question - Making sure text wraps and is fully visible
            ScrollView {
                Text(questions[currentQuestionIndex].text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true) // This ensures text wraps properly

                // Options
                VStack(spacing: 12) {
                    ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                        Button(action: {
                            selectedOptions[currentQuestionIndex] = index
                        }) {
                            HStack {
                                Text(questions[currentQuestionIndex].options[index])
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true) // Ensures option text wraps
                                
                                Spacer()
                                
                                if selectedOptions[currentQuestionIndex] == index {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.purple)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedOptions[currentQuestionIndex] == index ? Color.purple.opacity(0.1) : Color.gray.opacity(0.1))
                            )
                        }
                    }
                }
            }

            // Navigation buttons
            HStack {
                if currentQuestionIndex > 0 {
                    Button(action: {
                        withAnimation {
                            currentQuestionIndex -= 1
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Previous")
                        }
                        .foregroundColor(.purple)
                        .padding()
                    }
                }

                Spacer()

                Button(action: {
                    withAnimation {
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                        } else {
                            calculateResults()
                            showResults = true
                        }
                    }
                }) {
                    HStack {
                        Text(currentQuestionIndex < questions.count - 1 ? "Next" : "Finish")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(selectedOptions[currentQuestionIndex] != nil ? Color.purple : Color.gray)
                    )
                }
                .disabled(selectedOptions[currentQuestionIndex] == nil)
            }
            .padding(.top, 8)
        }
        .padding()
    }

    var resultsView: some View {
        ScrollView {
            VStack(spacing: 25) {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                    .foregroundColor(.purple)
                    .padding()

                Text("Your Mental Wellness Score")
                    .font(.headline)
                    .foregroundColor(.gray)

                Text("\(String(format: "%.1f", scoreOutOf10))/10")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(scoreColor)

                // Fixed text display with proper wrapping
                Text(feedbackText)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)

                Text(recommendationText)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)

                Spacer()
                    .frame(height: 20)

                Button(action: {
                    resetQuiz()
                }) {
                    Text("Take the Quiz Again")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: HomeView()) {
                    Text("Return to Home")
                        .foregroundColor(.purple)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    private var scoreColor: Color {
        if scoreOutOf10 >= 7.5 {
            return .green // Changed from red to green
        } else if scoreOutOf10 >= 5 {
            return .yellow // Changed from orange to yellow
        } else if scoreOutOf10 >= 2.5 {
            return .orange // Changed from yellow to orange
        } else {
            return .red // Changed from green to red
        }
    }

    private var feedbackText: String {
        if scoreOutOf10 >= 7.5 {
            return "Great job! Your mental wellness appears to be in good shape." // Changed
        } else if scoreOutOf10 >= 5 {
            return "Your mental wellness could benefit from some self-care practices." // Changed
        } else if scoreOutOf10 >= 2.5 {
            return "Your responses suggest moderate mental health challenges that should be addressed." // Changed
        } else {
            return "Your responses indicate significant stress and mental health concerns." // Changed
        }
    }

    private var recommendationText: String {
        if scoreOutOf10 >= 7.5 {
            return "Keep up your healthy habits! Continue with occasional meditation and mindfulness practices to maintain your excellent mental wellness." // Changed
        } else if scoreOutOf10 >= 5 {
            return "Regular mindfulness practice and occasional journaling can help maintain and improve your mental wellness. Try our guided meditations several times a week." // Changed
        } else if scoreOutOf10 >= 2.5 {
            return "Consider speaking with a counselor or therapist. Regular meditation, journaling, and breathing exercises can help manage your stress levels. Try to incorporate these practices into your daily routine." // Changed
        } else {
            return "We strongly recommend reaching out to a mental health professional. This is an important step in addressing your wellbeing. In the meantime, try using the breathing exercises and meditation sessions in this app daily." // Changed
        }
    }

    private func calculateResults() {
        totalScore = 0
        var answeredQuestions = 0

        for (index, selectedOption) in selectedOptions.enumerated() {
            if let option = selectedOption {
                totalScore += questions[index].scores[option]
                answeredQuestions += 1
            }
        }

        // Calculate score out of 10
        let maxPossibleScore = questions.count * 4 // 4 is max score per question
        let normalizedScore = Double(totalScore) / Double(maxPossibleScore) * 10
        scoreOutOf10 = normalizedScore
    }

    private func resetQuiz() {
        currentQuestionIndex = 0
        selectedOptions = Array(repeating: nil, count: questions.count)
        showResults = false
        totalScore = 0
    }
}
