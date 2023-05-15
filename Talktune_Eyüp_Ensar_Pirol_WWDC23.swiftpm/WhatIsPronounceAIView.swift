import SwiftUI

struct WhatIsPronounceAIView: View {
    @State private var showContent = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("What is TalkTune")
                    .font(.custom("American Typewriter", size: 40))
                    .foregroundColor(.white)
                    .padding(.top,50)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 5,x:10,y:10)   
                    .shadow(color: .black, radius: 1)   
                
                
                Text("So, what exactly does this test do? This test is a program for children with speech disorders. Using the Speech library, this application helps to identify signs of speech disorders in children. In this way, early diagnosis and necessary interventions can be made. 🗣︎ ")
                    .font(.system(size: 23))
                    .foregroundColor(.white)
                    .padding(.horizontal, 50)
                    .padding(.top, 10)
                    .padding(.bottom, 25)
                    .padding(.leading, 25)
                    .padding(.trailing,25)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 5)  
                
                Image("foto").resizable().frame(width: 500, height: 332).cornerRadius(30).shadow(radius: 5)
                
                Text("Moreover, it can help diagnose co-occurring learning disorders. Many learning disorders, such as speech disorders, can often co-occur. For example, learning disorders such as dyslexia, attention deficit hyperactivity disorder (ADHD) can co-occur. This app can help diagnose speech disorders while also diagnosing other learning disorders. In this way, children with learning disorders can be helped more effectively.📈  ")
                    .font(.system(size: 23))
                    .foregroundColor(.white)
                
                    .padding(.top, 25)
                    .padding(.bottom, 7)
                    .shadow(radius: 5)  
                    .padding(.leading, 25)
                    .padding(.trailing,25)
                    .multilineTextAlignment(.center)
                
       
                
                if !showContent {
                    Button(action: {
                        
                        withAnimation {
                            self.showContent = true
                        }
                    }) {
                        Text("Start Test!")   
                            .font(.system(size: 20))
                            .shadow(radius: 5)  
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(50)
                            .padding()
                            .shadow(radius: 1)  
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
            
            .navigationBarHidden(true)
            .background(Color(red: 9/255, green: 29/255, blue: 50/255))
            .foregroundColor(.white)
        }
        .fullScreenCover(isPresented: $showContent, content: SpeechTestView.init) 
    }
}
