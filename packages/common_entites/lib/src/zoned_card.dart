import 'dart:async';

import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';
import 'package:common_entites/src/weather_effect.dart';

part 'squad_card.dart';
part 'weather_cards/weather_card.dart';
part 'special_cards/special_card.dart';

sealed class ZonedCard extends CoreCard {
  CardZone? zone;
  final List<CardZone> availableZones;

  ZonedCard({
    required super.id,
    required super.name,
    required super.description,
    required this.zone,
    required this.availableZones,
    required super.ability,
  });
}
