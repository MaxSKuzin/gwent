import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/weather_effect.dart';

class MistCard extends WeatherCard {
  MistCard({
    required super.id,
  }) : super(
         name: 'Мгла',
         description: 'Вот туман-то... хоть глаз выколи',
         effect: WeatherEffect.mist,
         zone: CardZone.ranged,
         ability: 'Мгла',
       );
}
