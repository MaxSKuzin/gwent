import 'package:common_entites/common_entites.dart';

class OlgertFonEverek extends SquadCard {
  OlgertFonEverek({
    required super.id,
  }) : super(
         name: 'Ольгерд фон Эверек',
         description: 'Теперь ты, по крайней мере знает, что мне не так легко потерять голову.',
         baseStrength: 6,
         special: false,
         availableZones: [
           CardZone.melee,
           CardZone.ranged,
         ],
         ability: 'Прилив сил',
         modifier: StrengthBurst(),
       );
}
