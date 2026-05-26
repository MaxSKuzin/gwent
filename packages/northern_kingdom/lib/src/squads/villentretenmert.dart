import 'package:common_entites/common_entites.dart';

class Villentretenmert extends SquadCard {
  Villentretenmert({
    required super.id,
  }) : super(
         name: 'Виллентретенмерт',
         description: 'Дракон ушел от удара мягким, ловким, полным грации поворотом.',
         baseStrength: 7,
         special: false,
         availableZones: [CardZone.melee],
         ability: 'Казнь',
         modifier: Execution(),
       );
}
