import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';

class Sibling extends SquadModifier {
  final String aspect;

  Sibling({
    required this.aspect,
  });

  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
  }) {
    final hand = switch (player) {
      Player.player1 => field.player1Hand,
      Player.player2 => field.player2Hand,
    };

    final deck = switch (player) {
      Player.player1 => field.player1Deck,
      Player.player2 => field.player2Deck,
    };

    final similarCards = [...hand, ...deck].whereType<SquadCard>().where(
      (e) {
        final modifier = e.modifier;

        if (modifier is! Sibling) {
          return false;
        }

        return modifier.aspect.toLowerCase().contains(aspect.toLowerCase()) && e.id != card.id;
      },
    ).toList();

    for (final card in similarCards) {
      final zone = card.availableZones.first;

      field.playSquadCard(
        card,
        player,
        zone,
        performCardEffect: false,
      );

      hand.remove(card);
      deck.remove(card);
    }

    return true;
  }
}
