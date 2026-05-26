import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';

class StrongConnection extends SquadModifier {
  @override
  int calcStrength({
    required PlayField field,
    required Player player,
    required SquadCard card,
  }) {
    final zoneEffects = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == card.zone).effectsByPriority;

    final playerCards = switch (player) {
      Player.player1 => field.player1Cards,
      Player.player2 => field.player2Cards,
    };

    final sameCardsCount = playerCards.where((e) => e.name == card.name).length;

    int strength = card.baseStrength * sameCardsCount;

    for (final effect in zoneEffects) {
      switch (effect) {
        case FieldEffect.badWeather:
          strength = sameCardsCount;
        case FieldEffect.plusOne:
          strength += 1;
        case FieldEffect.boost:
          strength *= 2;
      }
    }

    return strength;
  }
}
