import 'package:common_entites/common_entites.dart';

class Taler extends SquadCard {
  Taler({
    required super.id,
  }) : super(
         name: 'Талер',
         description: 'Я вас всем глаза на жопу натяну!',
         baseStrength: 1,
         special: false,
         availableZones: [CardZone.siege],
         ability: null,
         modifier: Spy(),
       );
}
