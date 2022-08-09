//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 01/08/22.
//

import SwiftUI

enum Card: Int, CaseIterable, Comparable {

    case card2
    case card3
    case card4
    case card5
    case card6
    case card7
    case card8
    case card9
    case card10
    case jack
    case queen
    case king
    case ace
    
    var imageName: String {
        get {
            switch self {
            case .card2: return "card2"
            case .card3: return "card3"
            case .card4: return "card4"
            case .card5: return "card5"
            case .card6: return "card6"
            case .card7: return "card7"
            case .card8: return "card8"
            case .card9: return "card9"
            case .card10: return "card10"
            case .jack: return "card11"
            case .queen: return "card12"
            case .king: return "card13"
            case .ace: return "card14"
            }
        }
    }
    
    var image: UIImage {
        get {
            return UIImage(named: self.imageName) ?? UIImage()
        }
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var playerScore = 0
    @State var AIScore = 0
    @State var playerCard: Card = .ace
    @State var AICard: Card = .jack
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    Image(uiImage: playerCard.image)
                    Spacer()
                    Image(uiImage: AICard.image)
                    Spacer()
                }
                Spacer()
                Button(role: nil) {
                    onDealTapped()
                } label: {
                    Image("dealbutton")
                }
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        TVLVCSwiftUI { context in
                            let customVC = MyViewController()
                            return customVC
                        } updater: { vc, context in
                            if let myVC: MyViewController = vc as? MyViewController {
                                myVC.updateLabel(text: "\(playerScore)")
                            }
                        } coordinator: {
                            return MyCoordinator(playerScore: $playerScore, aiScore: $AIScore)
                        }
                        Text("Player")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 8.0)
                        Text("\(playerScore)")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                    }
                    Spacer()
                    VStack {
                        TVLViewSwiftUI ({ context in
                            let textfield = CustomUITextField()
                            print("Init textfield \(textfield)")
                            textfield.keyboardType = .numberPad
                            textfield.delegate = context.coordinator as! MyCoordinator
                            return textfield
                        }, updater: { view, _ in
                            // Update from SwiftUI to UIKit
                            if let textfield : UITextField = view as? UITextField {
                                textfield.text = String(AIScore)
                            }
                        }, coordinator: {
                            // Update from UIKit to SwiftUI
                            return MyCoordinator(playerScore: $playerScore, aiScore: $AIScore)
                        })
                        .background(Color.gray)
                        .frame(height: 55.0)
                        Text("AI")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 8.0)
                        Text("\(AIScore)")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                Button("Quit Game") {
                    presentationMode.wrappedValue.dismiss()
                }
                .background(Color.white)
                .foregroundColor(Color.blue)
            }
            Spacer()
        }
    }
    
    func onDealTapped() {
        // Generate random number
        playerCard = Card.allCases.randomElement() ?? Card.ace
        AICard = Card.allCases.randomElement() ?? Card.ace
        
        if playerCard > AICard {
            playerScore += 1
        }
        else if AICard > playerCard {
            AIScore += 1
        }
        else {
            // Tie, no op
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
