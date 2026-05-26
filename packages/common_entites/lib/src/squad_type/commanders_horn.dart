import 'package:common_entites/src/card_zone.dart';
import 'package:common_entites/src/field_effect.dart';
import 'package:common_entites/src/play_field.dart';
import 'package:common_entites/src/player.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';
import 'package:common_entites/src/zoned_card.dart';

class CommandersHorn extends SquadModifier {
  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
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
    required Player player,
    required SquadCard card,
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
          strength += 1;
        case FieldEffect.boost:
          break;
      }
    }

    return strength;
  }

  @override
  void remove({
    required PlayField field,
    required Player player,
    required SquadCard card,
    bool goesToShash = true,
  }) {
    final zoneField = switch (player) {
      Player.player1 => field.player1Zones,
      Player.player2 => field.player2Zones,
    }.firstWhere((e) => e.zone == card.zone);

    zoneField.effects.remove(FieldEffect.boost);
  }
}
