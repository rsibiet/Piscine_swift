
enum Color : String {
    case Spade = "Spade"
    case Diamond = "Diamond"
    case Heart = "Heart"
    case Club = "Club"
    static let allColors : [Color] = [Spade, Diamond, Heart, Club]
}

enum Value : Int {
    case Ace = 1
    case Two
    case Three
    case Four
    case Five
    case Six
    case Seven
    case Eight
    case Nine
    case Ten
    case Jack
    case Queen
    case King
    static let allValues : [Value] =
        [Ace, Two, Three, Four, Five, Six, Seven,
         Eight, Nine, Ten, Jack, Queen, King]
}

//print("Spade color: ", Color.Spade, "\nDiamond color: ", Color.Diamond,
//      "\nHeart color: ", Color.Heart, "\nClub color: ", Color.Club,
//      "\nallColors: ", Color.allColors)
//
//print("\nace value: ", Value.Ace, "\nfour value: ", Value.Four,
//      "\nten value: ", Value.Ten, "\n...\nallValues: ", Value.allValues)

import UIKit

class Card : NSObject {
    var color: Color
    var value: Value
    
    init (c: Color, v: Value) {
        self.color = c
        self.value = v
    }
    override var description : String {
        return "\(value, color)"
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return color == object.color && value == object.value
        }
        return false
    }
}

func ==(left: Card, right: Card) -> Bool {
    return (left.color == right.color && left.value == right.value)
}

//let card1 = Card(c : Color.Spade, v : Value.Ace)
//print(card1)
//
//let card2 = Card(c : Color.Diamond, v: Value.Two)
//print(card2)
//
//print(card1 == card2, "\n\n")

extension Array {
    mutating func shuffle() {
        for _ in 0..<((count>0) ? (count-1) : 0) {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map({Card(c: Color.Spade, v: $0)})
    static let allDiamonds : [Card] = Value.allValues.map({Card(c: Color.Diamond, v: $0)})
    static let allHearts : [Card] = Value.allValues.map({Card(c: Color.Heart, v: $0)})
    static let allClubs : [Card] = Value.allValues.map({Card(c: Color.Club, v: $0)})
    
    static let allCards : [Card] = allSpades + allDiamonds + allHearts + allClubs
    
    var cards : [Card] = allCards
    var discards : [Card] = []
    var outs : [Card] = []
    
    init(sort: Bool) {
        if sort == false {
            cards.shuffle()
        }
    }
    override var description: String {
        return "\(cards)"
    }
    func draw() -> Card? {
        outs.append(cards.first!)
        cards.removeFirst()
        return outs.last
    }
    func fold(c: Card) {
        var id = 0
        for inOut in outs {
            if c == inOut {
                outs.remove(at: id)
                discards.append(c)
                return
            }
            id += 1
        }
    }
}

var deck1 = Deck(sort: true)
var deck2 = Deck(sort: false)

print("Deck sorted: ", deck1)
print("\n\nouts content: ", deck1.outs,
      "\n\ndiscards content: ", deck1.discards)

deck1.draw()
print("\n\nouts content: ", deck1.outs,
      "\n\ndiscards content: ", deck1.discards)
deck1.draw()
print("\n\nouts content: ", deck1.outs,
      "\n\ndiscards content: ", deck1.discards)

var card1 = Card(c : Color.Spade, v : Value.Ace)

deck1.fold(c: card1)
print("\n\nouts content: ", deck1.outs,
      "\n\ndiscards content: ", deck1.discards)
deck1.draw()
print("\n\nouts content: ", deck1.outs,
      "\n\ndiscards content: ", deck1.discards)

card1 = Card(c : Color.Spade, v : Value.Queen)
deck1.fold(c: card1)
print("\n\nouts content: ", deck1.outs,
      "\n\ndiscards content: ", deck1.discards)


//var organisms = [
//    "ant",  "bacteria", "cougar",
//    "dog",  "elephant", "firefly",
//    "goat", "hedgehog", "iguana"]
//
//print("Original: \(organisms)")
//
//organisms.shuffle()
//
//print("Shuffled: \(organisms)")
















