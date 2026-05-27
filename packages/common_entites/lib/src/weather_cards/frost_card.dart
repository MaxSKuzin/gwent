import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/weather_effect.dart';

class FrostCard extends WeatherCard {
  FrostCard({
    required super.id,
  }) : super(
         name: 'Мороз',
         description: 'Мечта хорошего коммандира... кошмар плохого.',
         effect: WeatherEffect.frost,
         zone: CardZone.melee,
         ability: 'Мороз',
       );
}
