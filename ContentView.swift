import SwiftUI
import AVFoundation

struct ContentView: View {
    // States
    @State private var isHeads = true // true for heads, false for tails
    @State private var showCoinImage = true // To switch between coin images
    @State private var mute = false // Mute state
    
    // Audio Players
    var loonSound: AVAudioPlayer?
    var telephoneSound: AVAudioPlayer?
    
    // Coin flip function
    func flipCoin() {
        // Randomly select heads or tails
        isHeads.toggle()
        
        // Play the respective sound
        if isHeads {
            playSound("telephone_sound") // Replace with your audio file name for heads
        } else {
            playSound("loon_sound") // Replace with your audio file name for tails
        }
        
        // Show animation (flipping effect here)
        withAnimation {
            showCoinImage.toggle()
        }
    }
    
    // Play sound function
    func playSound(_ soundName: String) {
        if mute { return } // Don't play sound if muted
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch {
                print("Error playing sound")
            }
        }
    }
    
    // Mute/unmute function
    func toggleMute() {
        mute.toggle()
    }

    var body: some View {
        VStack {
            // Title
            Text("Coin Decider")
                .font(.largeTitle)
                .bold()
                .padding(.top, 50)

            Spacer()

            // Coin Image
            Image(isHeads ? "coin_skull" : "coin_loon") // Show heads or tails image
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()

            Spacer()

            // Flip Button
            Button(action: {
                flipCoin()
            }) {
                Text("Flip Coin")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
            
            // Mute Button
            Button(action: {
                toggleMute()
            }) {
                Image(systemName: mute ? "speaker.slash.fill" : "speaker.2.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(mute ? .red : .green)
            }
            .padding(.bottom, 50)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
