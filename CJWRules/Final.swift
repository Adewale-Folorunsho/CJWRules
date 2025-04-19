import SwiftUI

struct Final: View {
    // Color scheme matching previous views
    private let primaryPink = Color(red: 237/255, green: 78/255, blue: 178/255)
    private let primaryPurple = Color(red: 138/255, green: 43/255, blue: 226/255)
    private let lightPink = Color(red: 255/255, green: 182/255, blue: 232/255)
    private let lightPurple = Color(red: 230/255, green: 204/255, blue: 255/255)
    
    // The text to display
    let displayText: String
    
    init(text: String = "I love you more <3") {
        self.displayText = text
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Pure white background
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                // Decorative overlay
                VStack {
                    Text(displayText)
                        .font(.system(size: min(geometry.size.width * 0.15, 80), weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(primaryPurple)
                        .padding()
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.8))
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [lightPurple, lightPink]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                            }
                            .shadow(color: primaryPurple.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                        .padding()
                        .rotationEffect(Angle(degrees: -5))
                        .overlay(
                            GeometryReader { geo in
                                Color.clear.preference(key: CenterKey.self, value: geo.frame(in: .global).midX)
                            }
                        )
                        .animation(.spring(), value: displayText)
                }
            }
        }
    }
}

// Preference key to help with potential layout adjustments
struct CenterKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct FancyLargeTextView_Previews: PreviewProvider {
    static var previews: some View {
        Final(text: "Endless Love")
    }
}
