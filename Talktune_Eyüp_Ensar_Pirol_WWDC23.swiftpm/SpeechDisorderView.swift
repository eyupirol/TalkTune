import SwiftUI

struct SpeechDisorderView: View {
    @State private var showContent = false
    var body: some View {
        VStack {
            Text("What is the Speech Disorder")
                .font(.custom("American Typewriter", size: 40))
                .foregroundColor(.white)
            
                .padding(.top,50)
                .multilineTextAlignment(.center)
                .shadow(radius: 5,x:10,y:10)   
                .shadow(color: .black, radius: 1)          
            Text("The name says it all, but you might be asking yourself what exactly this speech disorder is? 🤔 ")
                .font(.system(size: 23))
                .foregroundColor(.white)
                .padding(.top, 5)
                .padding(.bottom, 30)
                .padding(.leading, 25)
                .padding(.trailing,25)
                .multilineTextAlignment(.center)
                .shadow(radius: 5)
            
            Image("foto1").resizable()
                .frame(width: 500.0, height: 332.0).cornerRadius(30).shadow(radius: 5)

            Text("Details: 👇")
                .font(.system(size: 23))
                .foregroundColor(.white)
                .padding(.top, 30)
                .padding(.bottom, 30)
                .multilineTextAlignment(.center)
                .shadow(radius: 5)  
            
            Text("Speech impairment is a common learning disability in children that affects their communication skills. It can cause difficulty with articulation, pronunciation, and grammar, hindering their ability to express themselves clearly. Early identification and intervention are crucial to prevent long-term difficulties with speech and language, which can significantly impact a child's academic and social development.")
                .font(.system(size: 23))
                .foregroundColor(.white)
                .padding(.top, 5)
                .padding(.bottom, 30)
                .padding(.leading, 25)
                .padding(.trailing,25)
                .multilineTextAlignment(.center)
                .shadow(radius: 5)  

            if !showContent {
                Button(action: {
                    
                    withAnimation {
                        self.showContent = true
                    }
                }) {
                    Text("Learn About TalkTune")  
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
        .fullScreenCover(isPresented: $showContent, content: WhatIsPronounceAIView.init) 
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .background(Color(red: 9/255, green: 29/255, blue: 50/255))
        .foregroundColor(.white)
        
    }
}
