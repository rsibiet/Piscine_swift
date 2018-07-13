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