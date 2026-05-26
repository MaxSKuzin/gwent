import 'package:common_entites/common_entites.dart';
import 'package:northern_kingdom/src/common/gunter_aspect.dart';

class GunterODimmDarkness extends SquadCard {
  GunterODimmDarkness({
    required super.id,
  }) : super(
         name: "Гюнтер О'Димм: тьма",
         description: 'Бойся не темноты, а света.',
         baseStrength: 4,
         special: false,
         availableZones: [CardZone.ranged],
         ability: 'Двойник',
         modifier: Sibling(aspect: GunterAspectSummon()),
       );
}
