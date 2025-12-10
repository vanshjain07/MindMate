//
//  ChatbotView.swift
//  MindMatey
//
//  Created by Vansh Jain on 04/05/25.
//
import SwiftUI
import WebKit

struct ChatbotView: View {
    @State private var isLoading = true
    @State private var error: Error? = nil
    
    var body: some View {
        ZStack {
            BotpressWebView(isLoading: $isLoading, error: $error)
                .edgesIgnoringSafeArea(.bottom)
            
            if isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                    Text("Loading your assistant...")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.7))
            }
            
            if error != nil {
                VStack(spacing: 20) {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    Text("Connection Error")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Please check your internet connection and try again.")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button(action: {
                        isLoading = true
                        error = nil
                        // This will trigger a reload in updateUIView
                    }) {
                        Text("Try Again")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
        }
        .navigationTitle("Chat Assistant")
    }
}

struct BotpressWebView: UIViewRepresentable {
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Configure WebView
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        webView.configuration.defaultWebpagePreferences = preferences
        
        // Set delegates
        webView.navigationDelegate = context.coordinator
        
        // Load Botpress webchat
        if let url = URL(string: "https://cdn.botpress.cloud/webchat/v2.4/shareable.html?configUrl=https://files.bpcontent.cloud/2025/05/04/10/20250504101235-WX8OBVJT.json") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // If error was cleared and isLoading is true, retry loading
        if error == nil && isLoading {
            if let url = URL(string: "https://cdn.botpress.cloud/webchat/v2.4/shareable.html?configUrl=https://files.bpcontent.cloud/2025/05/04/10/20250504101235-WX8OBVJT.json") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    
    // Coordinator to handle delegate callbacks
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: BotpressWebView
        
        init(_ parent: BotpressWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.error = error
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.error = error
        }
    }
}

struct ChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatbotView()
    }
}
