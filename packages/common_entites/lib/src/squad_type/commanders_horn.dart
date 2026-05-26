import 'dart:async';

import 'package:common_entites/src/card_zone.dart';
import 'package:common_entites/src/field_effect.dart';
import 'package:common_entites/src/play_field.dart';
import 'package:common_entites/src/player.dart';
import 'package:common_entites/src/zoned_card.dart';

mixin CommandersHorn on SquadCard {
  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
  }) {
    final zoneField = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == zone);

    zoneField.effects.add(FieldEffect.boost);

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
          strength += 1;
        case FieldEffect.boost:
          break;
      }
    }

    return strength;
  }

  @override
  FutureOr<void> remove(
    PlayField field,
    Player player, {
    bool goesToShash = true,
  }) {
    final zoneField = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == zone);

    zoneField.effects.remove(FieldEffect.boost);
  }
}
