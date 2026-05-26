import 'package:common_entites/common_entites.dart';

class ChoppersFromKrinfrid extends SquadCard {
  ChoppersFromKrinfrid({
    required super.id,
  }) : super(
         name: 'Рабайлы из Кринфрида',
         description: 'Записались мы на войну, а то с чудищами последнее время нам не шибко везет.',
         baseStrength: 5,
         special: false,
         availableZones: [CardZone.ranged],
         ability: 'Прочная связь',
         modifier: StrongConnection(),
       );
}
