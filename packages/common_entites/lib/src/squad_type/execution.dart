import 'dart:math';

import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/squad_type/squad_modifier.dart';

class Execution extends SquadModifier {
  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
    required SquadCard card,
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
    int totalStrength = 0;

    for (final card in enemyCards.where((e) => e.zone == zone)) {
      final cardStrength = card.calcStrength(
        field: field,
        player: switch (player) {
          Player.player1 => Player.player2,
          Player.player2 => Player.player1,
        },
      );

      totalStrength += cardStrength;

      stongestCardValue ??= cardStrength;
      stongestCardValue = max(stongestCardValue, cardStrength);
    }

    if (totalStrength >= 10 && stongestCardValue != null) {
      final cardsForRemoval = cards.where((e) {
        if (e.special || e.zone != zone) {
          return false;
        }

        final cardStrength = e.calcStrength(
          field: field,
          player: player,
        );

        return cardStrength == stongestCardValue;
      }).toList();

      final enemyCardsForRemoval = enemyCards.where((e) {
        if (e.special || e.zone != zone) {
          return false;
        }

        final cardStrength = e.calcStrength(
          field: field,
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

    return true;
  }
}
