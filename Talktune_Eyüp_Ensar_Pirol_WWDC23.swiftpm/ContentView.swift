import SwiftUI
import Speech

struct WelcomeView: View {
    @State private var isAnimating = false
    @State private var isReady = false
    
    @State private var showContent = false
    @ObservedObject private var speechRecognizer = SpeechRecognizer(wordsToRecognize: ["apple", "banana", "orange", "hello world"])
    
    var body: some View {
            VStack {
                if !showContent {
                    VStack(alignment: .center) {
                        Text("Welcome to TalkTune ")
                            .font(.custom("American Typewriter", size: 60))
                            .foregroundColor(.white)
                            .padding(3)
                        
                        Text("by Eyüp Ensar Pirol")
                            .font(.custom("Noteworthy", size: 35))
                            .foregroundColor(.white)
                            
                    }
                    
                    .offset(x: showContent ? -UIScreen.main.bounds.width : 0)
                    .animation(.easeInOut(duration: 1.5))
                }
                
                
                
                if !showContent {
                    Button(action: {
                        if speechRecognizer.isRecording {
                            speechRecognizer.stopRecording()
                        }
                        withAnimation {
                            self.showContent = true
                        }
                    }) {
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .transition(.move(edge: .trailing))
                            .animation(.easeInOut(duration: 1.5))
                            .padding(.top, 60)
                            
                        
                    }
                    .buttonStyle(PlainButtonStyle())
            }
            }
        
        .fullScreenCover(isPresented: $showContent) {
            NavigationView {
                SpeechDisorderView()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 9/255, green: 29/255, blue: 50/255))
    }
}


