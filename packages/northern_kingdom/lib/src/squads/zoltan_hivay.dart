import 'package:common_entites/common_entites.dart';

class ZoltanHivay extends SquadCard {
  ZoltanHivay({
    required super.id,
  }) : super(
         name: 'Золтан Хивай',
         description: 'Говорят, краснолюд ради товарища на виселицу пойдет. Золтан - не исключение.',
         baseStrength: 5,
         special: false,
         availableZones: [CardZone.melee],
         ability: null,
         modifier: null,
       );
}
