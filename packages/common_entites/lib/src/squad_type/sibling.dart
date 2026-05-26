import 'package:common_entites/common_entites.dart';

mixin Sibling<T extends Object> on SquadCard {
  T get aspect;

  @override
  bool play({
    required PlayField field,
    required CardZone zone,
    required Player player,
  }) {
    final hand = switch (player) {
      Player.player1 => field.player1Hand,
      Player.player2 => field.player2Hand,
    };

    final deck = switch (player) {
      Player.player1 => field.player1Deck,
      Player.player2 => field.player2Deck,
    };

    final similarCards = [...hand, ...deck]
        .where(
          (e) => e is Sibling && e.aspect is T && e.id != id,
        )
        .toList();

    for (final card in similarCards) {
      final zone = (card as SquadCard).availableZones.first;

      field.playSquadCard(
        card,
        player,
        zone,
        performCardEffect: false,
      );

      hand.remove(card);
      deck.remove(card);
    }

    return true;
  }
}
