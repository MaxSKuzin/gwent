import 'package:common_entites/src/card_zone.dart';
import 'package:common_entites/src/field_effect.dart';
import 'package:common_entites/src/play_field.dart';
import 'package:common_entites/src/player.dart';
import 'package:common_entites/src/zoned_card.dart';

class CommandersHornCard extends SpecialCard {
  CommandersHornCard({
    required super.id,
  }) : super(
         name: 'Командирский рог',
         description: 'Плюс один к морали, минус три к слуху',
         ability: 'Командирский рог',
         availableZones: CardZone.values,
         zone: null,
       );

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
}
