part of '../zoned_card.dart';

abstract class WeatherCard extends CoreCard {
  final WeatherEffect effect;
  final CardZone zone;
  final Player player;

  WeatherCard({
    required this.player,
    required super.id,
    required super.name,
    required super.description,
    required this.effect,
    required this.zone,
    required super.ability,
  });
}
