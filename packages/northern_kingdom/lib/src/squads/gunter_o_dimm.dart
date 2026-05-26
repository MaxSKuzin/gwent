import 'package:common_entites/common_entites.dart';
import 'package:northern_kingdom/src/common/gunter_aspect.dart';

class GunterODimm extends SquadCard {
  GunterODimm({
    required super.id,
  }) : super(
         name: "Гюнтер О'Димм",
         description: 'Он всегда дает именно то, чего ты хочешь. И в этом проблема',
         baseStrength: 4,
         special: false,
         availableZones: [CardZone.siege],
         ability: 'Двойник',
         modifier: Sibling(aspect: GunterAspectBase()),
       );
}
