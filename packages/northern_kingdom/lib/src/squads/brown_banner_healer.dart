import 'package:common_entites/common_entites.dart';

class BrownBannerHealer extends SquadCard with Medic {
  BrownBannerHealer({
    required super.id,
  }) : super(
         name: 'Лекарь Бурой Хоругви',
         description: 'Шейте красное с красным, желтое с желтым, белое с белым...',
         baseStrength: 5,
         special: false,
         availableZones: [CardZone.ranged],
         ability: 'Медик',
       );
}
