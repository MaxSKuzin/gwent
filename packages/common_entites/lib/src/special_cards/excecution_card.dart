import 'dart:math';

import 'package:common_entites/common_entites.dart';

class ExcecutionCard extends SpecialCard {
  ExcecutionCard({
    required super.id,
  }) : super(
         name: 'Казнь',
         description: 'Огненные столпы обращают величайших в пепел. Остальные благоговейно трепещут.',
         ability: 'Казнь',
         availableZones: [
           CardZone.melee,
           CardZone.ranged,
           CardZone.siege,
         ],
         zone: null,
       );

  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
  }) {
    final (cards, enemyCards) = switch (player) {
      Player.player1 => (
        field.player1Cards.whereType<SquadCard>().toList(),
        field.player2Cards.whereType<SquadCard>().toList(),
      ),
      Player.player2 => (
        field.player2Cards.whereType<SquadCard>().toList(),
        field.player1Cards.whereType<SquadCard>().toList(),
      ),
    };

    int? stongestCardValue;

    for (final card in [...cards, ...enemyCards]) {
      final cardStrength = card.calcStrength(
        field: field,
        zone: zone,
        player: switch (player) {
          Player.player1 => Player.player2,
          Player.player2 => Player.player1,
        },
      );

      stongestCardValue ??= cardStrength;
      stongestCardValue = max(stongestCardValue, cardStrength);
    }

    if (stongestCardValue != null) {
      final cardsForRemoval = cards.where((e) {
        if (e.special) {
          return false;
        }

        final cardStrength = e.calcStrength(
          field: field,
          zone: zone,
          player: player,
        );

        return cardStrength == stongestCardValue;
      }).toList();

      final enemyCardsForRemoval = enemyCards.where((e) {
        if (e.special) {
          return false;
        }

        final cardStrength = e.calcStrength(
          field: field,
          zone: zone,
          player: switch (player) {
            Player.player1 => Player.player2,
            Player.player2 => Player.player1,
          },
        );

        return cardStrength == stongestCardValue;
      }).toList();

      for (final card in cardsForRemoval) {
        field.removeSquadCard(player: player, card: card);
      }

      for (final card in enemyCardsForRemoval) {
        field.removeSquadCard(
          card: card,
          player: switch (player) {
            Player.player1 => Player.player2,
            Player.player2 => Player.player1,
          },
        );
      }
    }

    return false;
  }
}
