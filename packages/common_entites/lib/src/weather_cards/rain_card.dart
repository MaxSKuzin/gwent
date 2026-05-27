import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/weather_effect.dart';

class RainCard extends WeatherCard {
  RainCard({
    required super.id,
  }) : super(
         name: 'Ливень',
         description: 'В этом краю даже дождь смердит мочой',
         effect: WeatherEffect.rain,
         zone: CardZone.siege,
         ability: 'Ливень',
       );
}
