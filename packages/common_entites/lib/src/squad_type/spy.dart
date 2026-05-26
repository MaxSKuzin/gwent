import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';

class Spy extends SquadModifier {
  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
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

    oppositeCards.add(card);
    playerHand.remove(card);

    final newCards = playerDeck.take(2).toList();
    for (final card in newCards) {
      playerHand.add(card);
      playerDeck.remove(card);
    }

    return false;
  }
}
