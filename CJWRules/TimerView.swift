import SwiftUI

struct TimerView: View {
    @State private var currentTime = Date()
    @AppStorage("word1") private var originalWord1: String = "fierce"
    @AppStorage("word2") private var originalWord2: String = "intelligent"
    @AppStorage("word3") private var originalWord3: String = "beautiful"
    @AppStorage("word4") private var originalWord4: String = "breathtaking"
    @AppStorage("lastUpdateMinute") private var lastSynonymUpdateMinute = -1
    @AppStorage("isUpdating") private var isUpdating = false
    
    // Add these state variables at the top of your TimerView struct
    @State private var word1Animating = false
    @State private var word2Animating = false
    @State private var word3Animating = false
    @State private var word4Animating = false
    
    
    
    // Fixed lists of synonyms for each word
    // First position adjectives (should work after "the")
    private let synonyms1 = [
        "sweet", "kind", "lovely", "cute", "adorable", "funny",
        "smart", "cool", "pretty", "sexy", "fierce",
        "homely", "caring", "loving", "amazing"
    ]
    
    // Second position adjectives (no "the" before)
    private let synonyms2 = [
        "beautiful", "incredible", "wonderful", "gorgeous", "perfect",
        "talented", "brilliant", "thoughtful", "charming", "adorable",
        "special", "fantastic", "awesome", "stunning", "loving"
    ]
    
    // Third position adjectives (no "the" before)
    private let synonyms3 = [
        "hilarious", "intelligent", "creative", "sweet", "honest",
        "fun", "caring", "gentle", "passionate", "smart",
        "funny", "clever", "kind", "exciting", "understanding"
    ]
    
    // Fourth position adjectives (should work after "the")
    private let synonyms4 = [
        "most amazing", "most beautiful", "most wonderful", "most perfect",
        "most incredible", "most adorable", "best", "most special", "most awesome",
        "most gorgeous", "most loving", "most talented", "most brilliant", "most fantastic"
    ]
    
    private let initialDate: Date = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: "2024-03-24") ?? Date()
    }()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Pink and Purple theme colors
    private let primaryPink = Color(red: 237/255, green: 78/255, blue: 178/255)
    private let primaryPurple = Color(red: 138/255, green: 43/255, blue: 226/255)
    private let lightPink = Color(red: 255/255, green: 182/255, blue: 232/255)
    private let lightPurple = Color(red: 230/255, green: 204/255, blue: 255/255)
    
    var body: some View {
        VStack(spacing: 25) {
            Text("It has been")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(primaryPurple)
                .padding(.top, 20)
            
            // Time components in a grid
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    TimeComponent(
                        value: daysBetween(initialDate, and: currentTime),
                        unit: "Days",
                        color: primaryPurple
                    )
                    
                    TimeComponent(
                        value: hoursBetween(initialDate, and: currentTime) % 24,
                        unit: "Hours",
                        color: primaryPink
                    )
                }
                
                HStack(spacing: 16) {
                    TimeComponent(
                        value: minutesBetween(initialDate, and: currentTime) % 60,
                        unit: "Minutes",
                        color: primaryPink
                    )
                    
                    TimeComponent(
                        value: secondsBetween(initialDate, and: currentTime) % 60,
                        unit: "Seconds",
                        color: primaryPurple
                    )
                }
                
                // Combined text with inline animation
                Text("of being with the most \(originalWord1), \(originalWord2), \(originalWord3), and the \(originalWord4) woman in the world!")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(primaryPurple)
                    .multilineTextAlignment(.center)
                    .overlay(
                        ZStack {
                            if word1Animating {
                                Image(systemName: "sparkle")
                                    .foregroundColor(.yellow)
                                    .offset(x: -100) // Approximate position for first word
                            }
                            if word2Animating {
                                Image(systemName: "sparkle")
                                    .foregroundColor(.yellow)
                                    .offset(x: -50) // Approximate position for second word
                            }
                            if word3Animating {
                                Image(systemName: "sparkle")
                                    .foregroundColor(.yellow)
                                    .offset(x: 0) // Approximate position for third word
                            }
                            if word4Animating {
                                Image(systemName: "sparkle")
                                    .foregroundColor(.yellow)
                                    .offset(x: 60) // Approximate position for fourth word
                            }
                        }
                    )
                    .padding(.top, 20)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, lightPink.opacity(0.3)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
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
            .shadow(color: Color.purple.opacity(0.2), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
        .onReceive(timer) { _ in
            self.currentTime = Date()
            let currentMinute = Calendar.current.component(.minute, from: currentTime)
            if currentMinute != lastSynonymUpdateMinute && lastSynonymUpdateMinute >= 0 {
                lastSynonymUpdateMinute = currentMinute
                updateWordsWithAnimation()
            }
            
            if lastSynonymUpdateMinute < 0 {
                lastSynonymUpdateMinute = 0
            }
        }
    }
    private func updateWordsWithAnimation() {
        
        if isUpdating {
            return
        }
        
        isUpdating = true
        
        // Word 1 animation and update
        withAnimation {
            word1Animating = true
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            originalWord1 = synonyms1.randomElement() ?? "Loading..."
            withAnimation {
                word1Animating = false
            }
            
            // Word 2 animation and update
            withAnimation {
                word2Animating = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                originalWord2 = synonyms2.randomElement() ?? "Loading..."
                withAnimation {
                    word2Animating = false
                }
                
                // Word 3 animation and update
                withAnimation {
                    word3Animating = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    originalWord3 = synonyms3.randomElement() ?? "Loading..."
                    withAnimation {
                        word3Animating = false
                    }
                    
                    // Word 4 animation and update
                    withAnimation {
                        word4Animating = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        originalWord4 = synonyms4.randomElement() ?? "Loading..."
                        withAnimation {
                            word4Animating = false
                        }
                        isUpdating = false
                    }
                }
            }
        }
    }
}

// Helper methods for time calculation
private func secondsBetween(_ date1: Date, and date2: Date) -> Int {
    return Int(date2.timeIntervalSince(date1))
}

private func minutesBetween(_ date1: Date, and date2: Date) -> Int {
    return secondsBetween(date1, and: date2) / 60
}

private func hoursBetween(_ date1: Date, and date2: Date) -> Int {
    return minutesBetween(date1, and: date2) / 60
}

private func daysBetween(_ date1: Date, and date2: Date) -> Int {
    return hoursBetween(date1, and: date2) / 24
}

struct TimeComponent: View {
    let value: Int
    let unit: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 5) {
            Text("\(value)")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(color)
                .minimumScaleFactor(0.6)
                .lineLimit(1)
            
            Text(unit)
                .font(.system(size: 16, weight: .semibold)) // Added weight
                .foregroundColor(color.opacity(0.7)) // Use the same color as the value, but with opacity
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.8))
                .shadow(color: color.opacity(0.2), radius: 4, x: 0, y: 2)
        )
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
