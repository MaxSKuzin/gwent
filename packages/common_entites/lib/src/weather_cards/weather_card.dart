part of '../zoned_card.dart';

abstract class WeatherCard extends CoreCard {
  final WeatherEffect effect;
  final CardZone zone;
  Player? player;

  WeatherCard({
    required super.id,
    required super.name,
    required super.description,
    required this.effect,
    required this.zone,
    required super.ability,
  });
}
