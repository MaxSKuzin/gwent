part of '../zoned_card.dart';

abstract class SpecialCard extends ZonedCard {
  SpecialCard({
    required super.id,
    required super.name,
    required super.description,
    required super.zone,
    required super.availableZones,
    required super.ability,
  });

  FutureOr<bool> play({
    required PlayField field,
    required CardZone zone,
    required Player player,
  });
}
