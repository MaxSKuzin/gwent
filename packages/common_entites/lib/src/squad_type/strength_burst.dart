import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';

class StrengthBurst extends SquadModifier {
  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
  }) {
    final fieldZone = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == zone);

    fieldZone.effects.add(FieldEffect.plusOne);

    return true;
  }

  @override
  int calcStrength({
    required PlayField field,
    required SquadCard card,
    required Player player,
  }) {
    final zoneEffects = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == card.zone).effectsByPriority;

    int strength = card.baseStrength;

    for (final effect in zoneEffects) {
      switch (effect) {
        case FieldEffect.badWeather:
          strength = 1;
        case FieldEffect.plusOne:
          break;
        case FieldEffect.boost:
          strength *= 2;
      }
    }

    return strength;
  }

  @override
  void remove({
    required PlayField field,
    required Player player,
    bool goesToShash = true,
    required SquadCard card,
  }) {
    final fieldZone = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == card.zone);

    final burstingCards = switch (player) {
      Player.player1 => field.player1Cards,
      Player.player2 => field.player2Cards,
    }.where((e) => e.zone == card.zone && e is StrengthBurst);

    if (burstingCards.isEmpty) {
      fieldZone.effects.remove(FieldEffect.plusOne);
    }
  }
}
