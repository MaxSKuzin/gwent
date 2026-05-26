part of 'zoned_card.dart';

abstract class SquadCard extends ZonedCard {
  final int baseStrength;
  final bool special;

  SquadCard({
    required super.id,
    required super.name,
    required super.description,
    required this.baseStrength,
    required this.special,
    required super.availableZones,
    required super.ability,
    super.zone,
  });

  int calcStrength({
    required PlayField field,
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
          strength += 1;
        case FieldEffect.boost:
          strength *= 2;
      }
    }

    return strength;
  }

  /// Used for performing custom actions such as execution, return bool if card should be placed in provided player field
  FutureOr<bool> play({
    required PlayField field,
    required CardZone zone,
    required Player player,
  }) async => true;

  FutureOr<void> remove(
    PlayField field,
    Player player, {
    bool goesToShash = true,
  }) {}
}
