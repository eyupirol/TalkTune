import SwiftUI

struct ThankYouView: View {
    @State private var showContent = false
    
    @State private var isRestarting = false
    
    var body: some View {
        VStack {
            
            Text("That's about it!")
                .font(.custom("American Typewriter", size: 40))
                .foregroundColor(.white)
                .padding(.top,300)
                .multilineTextAlignment(.center)
                .shadow(radius: 5,x:10,y:10)   
                .shadow(color: .black, radius: 1)   
            
            Text("You've completed the playground! 🎊 Now you are aware of the condition called speech impairment and have tried a new way to diagnose it early with just a computer!🤩")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(.horizontal, 50)
                .padding(.top, 25)
                .padding(.bottom, 7)
                .shadow(radius: 5)  
                .padding(.leading, 25)
                .padding(.trailing,25)
                .multilineTextAlignment(.center)
            
            Text("It has been a great pleasure for me to create in the spirit of WWDC throughout this journey. I hope to see you at WWDC23! 🤟🎈")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(.horizontal, 50)
                .padding(.top, 25)
                .padding(.bottom, 7)
                .shadow(radius: 5)  
                .padding(.leading, 25)
                .padding(.trailing,25)
                .multilineTextAlignment(.center)
            
            
            if !showContent {
                Button(action: {
                    showContent = true                     
                }) {
                    Text("Restart")   .font(.system(size: 20))
                        .shadow(radius: 5)  
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(50)
                        .padding()
                        .shadow(radius: 1)  
                }
                .buttonStyle(PlainButtonStyle())
                .padding(50)
            }            
            Spacer()
        }
        .background(Color(red: 9/255, green: 29/255, blue: 50/255))
        .fullScreenCover(isPresented: $showContent, content: WelcomeView.init) 
    }
}
