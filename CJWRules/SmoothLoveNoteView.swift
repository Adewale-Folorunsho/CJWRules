import SwiftUI

struct SmoothLoveNoteView: View {
    // State to track the current date and love note
    @State private var currentDate = Date()
    @State private var loveNote = ""
    @AppStorage("noteCounter") private var noteCounter: Int = 0
    
    // Smooth Color Palette
    private let baseBackground = Color.white
    private let primaryColor = Color(red: 0.55, green: 0.27, blue: 0.67) // Soft purple
    private let accentColor = Color(red: 0.93, green: 0.31, blue: 0.55) // Soft pink
    
    // Comprehensive List of Love Notes
    private let dailyLoveNotes = [
        "Every moment with you feels like magic",
        "You are the most beautiful part of my world",
        "Loving you is my favorite thing to do",
        "You make every day brighter and more beautiful",
        "Every day I fall in love with you more deeply",
        "You are my peace, my joy, my everything",
        "You are the most incredible gift I've ever received",
        "Meeting you was like finding my missing piece",
        "I love you more than words can ever express",
        "You light up my life in ways I can't describe",
        "I'm so lucky to have you in my life",
        "Every day with you is a gift",
        "You are my soulmate, confidante, and best friend",
        "I love you more than yesterday, but not as much as tomorrow",
        "I'm so grateful to have you in my life",
        "Thinking of you makes me feel like the luckiest person alive",
        "Every day with you is a new adventure I look forward to",
        "You are my everything, my everything, my everything",
        "I can't wait to spend the rest of my life with you",
        "Thank you for making me the happiest person alive",
        "Being with you makes me want to be the best that I can be",
        "I can't imagine my life without you",
        "I can't wait to have you by my side everyday",
        "I can't wait to wake up next to you",
        "You're the light of my life",
        "You're the only cockroach in my cupboard",
        "You're the apple of my eyes",
        "Everyday that I get to look at you is a blessing to me",
        "You're the most beautiful woman in the world",
        "You're the sugar in my tea",
        "You're the mosquito in my net",
        "Shall I compare thee to a summer’s day?\nThou art more lovely and more temperate\n\nWilly Shakes. (This is the only poem I know :-< )",
        "I would rather look at you than all the portraits in the world",
        "Your smile is the highlight of my every day",
        "In your eyes, I've found my forever home",
        "Your laugh is my favorite melody",
        "Holding your hand feels like holding my entire world",
        "With you, ordinary moments become extraordinary memories",
        "You're the dream I never knew I needed",
        "Every little thing you do makes me fall deeper in love",
        "Your heart is the most beautiful place I've ever been invited into",
        "I love the way you think, the way you speak, the way you love",
        "You make even the darkest days feel full of light",
        "Being yours is the greatest honor of my life",
        "Your love has taught me what it means to truly live",
        "When I look at you, I see my past, present, and future",
        "You are the wish I never knew how to say",
        "In a world of uncertainty, you are my constant",
        "The sound of your voice is my favorite sound in the world",
        "Your touch makes me feel alive in ways I never knew possible",
        "You've shown me what love truly means",
        "I cherish every second I get to spend with you",
        "You are the answer to every question my heart has ever asked",
        "My favorite place in the world is wherever you are",
        "You're not just my love story; you're my favorite chapter",
        "With you, I've found the meaning of true happiness",
        "Your love is the most beautiful thing I've ever felt",
        "You're the first thought in my morning and the last thought before I sleep",
        "In your arms is where I belong forever",
        "You make my heart skip a beat every single time",
        "I adore everything about you, from your smile to your soul",
        "You've made me believe in magic again",
        "Loving you is as essential to me as breathing",
        "You are my sunshine on the cloudiest days",
        "Your kindness and compassion inspire me every day",
        "In your love, I have found my home",
        "You have the most beautiful soul I've ever known",
        "Every moment with you feels like a precious gift",
        "Your love has transformed me in the most wonderful ways",
        "Being loved by you is the greatest blessing of my life",
        "You are my favorite reason to wake up every morning",
        "The world is more beautiful because you're in it",
        "Your heart and mind are equally beautiful to me",
        "I fall more in love with you with each passing day",
        "You are the poetry that flows through my veins",
        "Your presence in my life makes everything better",
        "In your eyes, I see the reflection of my best self",
        "You've taught me what unconditional love truly means",
        "With you, I've found a love I never thought possible",
        "You are the melody that plays in my heart",
        "Every day with you is my favorite day",
        "You make my heart feel like it could burst with happiness",
        "In this lifetime and beyond, my heart is forever yours",
        "You are the reason my heart beats a little faster",
        "Everything about you captivates me completely",
        "Your love feels like coming home after a long journey",
        "Each day with you is better than the last",
        "I never knew what true love was until I found you",
        "You're the missing piece that makes my life complete",
        "The way you look at me still gives me butterflies",
        "Loving you is the easiest thing I've ever done",
        "You bring color to my world in ways nothing else can",
        "I find pieces of you in everything beautiful",
        "Your love is the anchor that keeps me grounded",
        "Being with you makes me feel invincible",
        "You're the first and last thing on my mind every day",
        "In your embrace, I've found my paradise",
        "The universe conspired to bring us together",
        "Every love song reminds me of you",
        "You make ordinary days feel extraordinary",
        "My heart recognized yours before we even spoke",
        "Your love is the greatest adventure of my life",
        "I'm endlessly fascinated by everything about you",
        "You're the wish I never knew to make",
        "In you, I've found my reason, my purpose, my joy",
        "Every second with you is a treasure beyond measure",
        "Your smile could light up the darkest night",
        "I want to spend eternity discovering all the ways to love you",
        "You've shown me what it means to be truly seen",
        "My love for you grows deeper with each passing moment",
        "You are my favorite hello and my hardest goodbye",
        "The stars shine brighter when I'm with you",
        "In a thousand lifetimes, I'd still choose you"
    ]
    
    // Special May 14th Note
    private let may14thNote = "Happy Birthday Ms CJ!\n\nI'm otp with you rn watching Little Man. And all I can think about is how much I love you and how you make my life so much better just byu being in it. I don't know how the rest of your day is going to be but I want you to know that you deserve the world and so much more. You're such an amazing person and I really hope you get to see yourself as the amazing, sexy and charismatic woman that you are.\n\nHappy Birthday and I love you <3"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Smooth Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        baseBackground,
                        primaryColor.opacity(0.05),
                        baseBackground
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Date Header
                    HStack {
                        Text(formattedDate)
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(primaryColor.opacity(0.7))
                        
                        Spacer()
                        
                        Image(systemName: "heart.fill")
                            .foregroundColor(accentColor.opacity(0.5))
                            .font(.system(size: 20))
                    }
                    .padding()
                    
                    // Smooth Note Container
                    ZStack {
                        // Smooth Background
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .shadow(color: primaryColor.opacity(0.1), radius: 15, x: 0, y: 8)
                        
                        VStack(spacing: 15) {
                            Text("Today's Note")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(primaryColor)
                            
                            // Use GeometryReader to center the text in the available space
                            GeometryReader { geo in
                                ScrollView {
                                    // This VStack centers the content before scrolling becomes necessary
                                    VStack {
                                        // Add spacer to push content to center
                                        Spacer()
                                        
                                        // Love note text centered in the view
                                        Text(loveNote)
                                            .font(.system(size: 22, weight: .medium, design: .rounded))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(primaryColor.opacity(0.9))
                                            .padding()
                                            .lineSpacing(5)
                                        
                                        // Add spacer to push content to center
                                        Spacer()
                                    }
                                    .frame(minHeight: geo.size.height)
                                }
                            }
                        }
                        .padding()
                    }
                    .padding()
                    .frame(height: geometry.size.height * 0.5)
                }
                .padding(.horizontal)
            }
        }
        .onAppear(perform: updateLoveNoteIfNeeded)
        .animation(.smooth(duration: 0.5), value: loveNote)
    }
    
    // Formatted Date
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: currentDate)
    }
    
    // Update love note only if it's a new day
    func updateLoveNoteIfNeeded() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Check if it's May 14th
        let components = calendar.dateComponents([.month, .day], from: today)
        if components.month == 4 && components.day == 18 {
            loveNote = may14thNote
            return
        }
        
        // Check if stored note is from a different day
        if let lastUpdateDate = UserDefaults.standard.object(forKey: "LoveNoteDate") as? Date,
           !calendar.isDate(today, inSameDayAs: lastUpdateDate) {
            generateLoveNote()
            UserDefaults.standard.set(today, forKey: "LoveNoteDate")
        } else if loveNote.isEmpty {
            // Generate note if no note exists
            generateLoveNote()
            UserDefaults.standard.set(today, forKey: "LoveNoteDate")
        } else {
            // Retrieve existing note
            loveNote = UserDefaults.standard.string(forKey: "LoveNote") ?? generateLoveNote()
        }
    }
    
    // Generate a unique love note
    @discardableResult
    func generateLoveNote() -> String {
        // Use the current date to seed the random number generator
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        
        // Use day and month to deterministically select a note
        let noteIndex = (day + month) % dailyLoveNotes.count
        
        loveNote = dailyLoveNotes[noteIndex]
        
        // Save note to UserDefaults
        UserDefaults.standard.set(loveNote, forKey: "LoveNote")
        
        return loveNote
    }
}

struct SmoothLoveNoteView_Previews: PreviewProvider {
    static var previews: some View {
        SmoothLoveNoteView()
    }
}
