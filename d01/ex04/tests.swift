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