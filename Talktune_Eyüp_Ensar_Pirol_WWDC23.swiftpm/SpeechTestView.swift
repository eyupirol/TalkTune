import SwiftUI

struct SpeechTestView: View {
    @State private var showContent = false
    @State private var showContent2 = false
    @StateObject private var speechRecognizer = SpeechRecognizer(wordsToRecognize: ["apple", "banana", "orange", "hello world"])
    @State private var userAnswers = [String: Bool]()
    @State private var showRestartAlert = false
    @State private var alertTitle = " "
    @State private var alertMessage = " "
    
    var body: some View {  
        VStack {
            Text("Speech Impediment Test ")
                .font(.custom("American Typewriter", size: 30))
                .foregroundColor(.white)
                .padding(.top, 20)
                .padding(.bottom, 20)
                .shadow(radius: 5,x:10,y:10)   
                .shadow(color: .black, radius: 1)
            Text("Let’s try it!!")
                .font(.system(size: 20))
                .shadow(radius: 5)  
            Text("Try to say the words correctly one by one!")
                .font(.system(size: 20))
                .shadow(radius: 5)  
                .padding(.bottom, 20)
            
            Button(speechRecognizer.isRecording ? "Stop" : "Start") {
                if speechRecognizer.isRecording {
                    speechRecognizer.stopRecording()
                    checkResults()
                } else {
                    speechRecognizer.startRecording()
                }
            }   
            .font(.system(size: 20))
            .shadow(radius: 5)  
            .padding()
            .background(speechRecognizer.isRecording ? Color.red : Color.orange)
            .foregroundColor(.white)
            .cornerRadius(50)
            .shadow(radius: 1) 
            
            Text(speechRecognizer.recognizedText)
                .padding()
            
            ForEach(speechRecognizer.wordsToRecognize, id: \.self) { word in
                HStack {
                    Image(word).resizable().frame(width: 60, height: 60).aspectRatio(contentMode: .fit).padding(.leading,100)
                    Text(word.capitalized).font(.system(size: 20)).padding(.leading,250)
                    Spacer()
                    if let isCorrect = userAnswers[word] {
                        Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(isCorrect ? .green : .red)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(75)
                .padding()
            }
            
            if !showContent {
                Button(action: {
                    withAnimation {
                        self.showContent = true
                    }
                }) {
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut(duration: 1.5))
                        .padding(.bottom,20)
                    //.padding(.top,-300)
                }
                .buttonStyle(PlainButtonStyle())
            }            
        }
        
        .onChange(of: speechRecognizer.recognizedText, perform: { recognizedText in
            for word in speechRecognizer.wordsToRecognize {
                if recognizedText.lowercased().contains(word) {
                    userAnswers[word] = true
                } else {
                    userAnswers[word] = false
                }
            }
        })
        .alert(isPresented: $showRestartAlert, content: {
            Alert(title: Text(alertTitle),
                  message: Text(alertMessage),
                  primaryButton: .default(Text("Restart"), action: {
                withAnimation {
                    self.showContent2 = true
                }                  }),
                  secondaryButton: .cancel())
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 9/255, green: 29/255, blue: 50/255))
        .fullScreenCover(isPresented: $showContent, content: ThankYouView.init)
        .fullScreenCover(isPresented: $showContent2, content: SpeechTestView.init) 
    }
    
    private var healthy: String {
        if userAnswers.count == speechRecognizer.wordsToRecognize.count, userAnswers.values.allSatisfy({ $0 == true }) {
            return "Healthy!"
        } else {
            return ""
        }
    }
    
    private func checkResults() {
        let wrongAnswers = userAnswers.filter { !$0.value }.count
        if healthy == "Healthy!"{
            showRestartAlert = true
            alertTitle = "You have regular speech."
            alertMessage = "It seems you have regular speech. Would you like to try again?"
        } else if wrongAnswers >= 1 {
            showRestartAlert = true
            alertTitle = "You may have a speech disorder."
            alertMessage = "It seems you have a speech disorder. Would you like to try again?"
        }
    }
    
    private func resetTest() {
        speechRecognizer.wordsToRecognize = ["apple", "banana", "orange", "hello world"]
        userAnswers.removeAll()
    }
}
