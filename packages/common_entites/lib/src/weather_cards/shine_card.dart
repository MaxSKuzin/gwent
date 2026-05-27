import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/weather_effect.dart';

class ShineCard extends WeatherCard {
  ShineCard({
    required super.id,
  }) : super(
         name: 'Ясное небо',
         description: 'Дромил, солнце-то светит! Значит и надежда есть...',
         effect: WeatherEffect.shine,
         zone: CardZone.melee,
         ability: 'Ясное небо',
       );
}
