import 'package:common_entites/common_entites.dart';

mixin StrengthBurst on SquadCard {
  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
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
    required CardZone zone,
    required Player player,
  }) {
    final zoneEffects = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == zone).effectsByPriority;

    int strength = baseStrength;

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
  void remove(
    PlayField field,
    Player player, {
    bool goesToShash = true,
  }) {
    final fieldZone = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == zone);

    final burstingCards = switch (player) {
      Player.player1 => field.player1Cards,
      Player.player2 => field.player2Cards,
    }.where((e) => e.zone == zone && e is StrengthBurst);

    if (burstingCards.isEmpty) {
      fieldZone.effects.remove(FieldEffect.plusOne);
    }
  }
}
