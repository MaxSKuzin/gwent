import 'package:common_entites/common_entites.dart';

mixin Spy on SquadCard {
  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
  }) {
    final (playerHand, playerDeck, oppositeCards) = switch (player) {
      Player.player1 => (
        field.player1Hand,
        field.player1Deck,
        field.player2Cards,
      ),
      Player.player2 => (
        field.player2Hand,
        field.player2Deck,
        field.player1Cards,
      ),
    };

    oppositeCards.add(this);
    playerHand.remove(this);

    final newCards = playerDeck.take(2).toList();
    for (final card in newCards) {
      playerHand.add(card);
      playerDeck.remove(card);
    }

    return false;
  }
}
