import 'package:common_entites/common_entites.dart';

class Lutik extends SquadCard with CommandersHorn {
  Lutik({
    required super.id,
  }) : super(
         name: 'Лютик',
         description: 'Ты циник, свинтус, бабник и лжец. И поверь, ничего сложного в тебе нет.',
         baseStrength: 2,
         special: false,
         availableZones: [CardZone.melee],
         ability: 'Командирский рог',
       );
       
}
