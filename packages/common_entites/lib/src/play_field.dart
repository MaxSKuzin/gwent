import 'package:common_entites/common_entites.dart';
import 'package:common_entites/src/field_zone.dart';
import 'package:common_entites/src/weather_effect.dart';

class PlayField {
  final Future<SquadCard?> Function(List<SquadCard> stash) restoreCard;
  final Future<SquadCard?> Function(List<SquadCard> cards) pickCard;

  final List<CoreCard> player1Hand;
  final List<CoreCard> player1Deck;
  final List<CoreCard> player2Hand;
  final List<CoreCard> player2Deck;

  PlayField({
    required this.player1Hand,
    required this.player1Deck,
    required this.player2Hand,
    required this.player2Deck,
    required this.restoreCard,
    //TODO: remove
    required this.player2Cards,
    required this.pickCard,
  });

  final player1Zones = [
    FieldZone(zone: CardZone.melee, effects: {}),
    FieldZone(zone: CardZone.ranged, effects: {}),
    FieldZone(zone: CardZone.siege, effects: {}),
  ];
  final player2Zones = [
    FieldZone(zone: CardZone.melee, effects: {}),
    FieldZone(zone: CardZone.ranged, effects: {}),
    FieldZone(zone: CardZone.siege, effects: {}),
  ];

  final Set<WeatherCard> weatherCards = {};

  var player1Cards = <ZonedCard>[];
  List<ZonedCard> player2Cards;

  var player1Stash = <CoreCard>[];
  var player2Stash = <CoreCard>[];

  Future<void> playSquadCard(
    SquadCard card,
    Player player,
    CardZone zone, {
    bool performCardEffect = true,
  }) async {
    final playerCards = switch (player) {
      Player.player1 => player1Cards,
      Player.player2 => player2Cards,
    };

    card.zone = zone;

    final placeToPlayer = performCardEffect
        ? await card.play(
            field: this,
            zone: card.zone!,
            player: player,
          )
        : true;

    if (placeToPlayer) {
      playerCards.add(card);
      final hand = switch (player) {
        Player.player1 => player1Hand,
        Player.player2 => player1Hand,
      };

      hand.remove(card);
    }
  }

  Future<void> playWeatherCard(WeatherCard card, Player player) async {
    card.player = player;
    switch (card.effect) {
      case WeatherEffect.frost:
      case WeatherEffect.rain:
      case WeatherEffect.mist:
        player1Zones.firstWhere((e) => e.zone == card.zone).effects.add(FieldEffect.badWeather);
        player2Zones.firstWhere((e) => e.zone == card.zone).effects.add(FieldEffect.badWeather);
        weatherCards.add(card);
      case WeatherEffect.shine:
        for (final zone in player1Zones) {
          zone.effects.remove(FieldEffect.badWeather);
        }
        for (final zone in player2Zones) {
          zone.effects.remove(FieldEffect.badWeather);
        }
        final stash = switch (card.player) {
          Player.player1 => player1Stash,
          Player.player2 => player2Stash,
          _ => null,
        };
        for (final card in weatherCards) {
          stash?.add(card);
        }
        weatherCards.clear();
        stash?.add(card);
    }

    final hand = switch (player) {
      Player.player1 => player1Hand,
      Player.player2 => player2Hand,
    };

    hand.remove(card);
  }

  Future<void> removeSquadCard({
    required Player player,
    required SquadCard card,
    bool regularRemoval = true,
  }) async {
    final (list, stash) = switch (player) {
      Player.player1 => (player1Cards, player1Stash),
      Player.player2 => (player2Cards, player2Stash),
    };

    if (!list.contains(card)) {
      return;
    }

    list.remove(card);
    if (regularRemoval) {
      stash.add(card);
    }
    card.remove(
      this,
      player,
      goesToShash: regularRemoval,
    );
  }

  Future<void> playSpecialCard({
    required Player player,
    required CardZone zone,
    required SpecialCard card,
  }) async {
    card.zone = zone;

    final placeToPlayer = await card.play(
      field: this,
      zone: zone,
      player: player,
    );

    final hand = switch (player) {
      Player.player1 => player1Hand,
      Player.player2 => player2Hand,
    };
    hand.remove(card);

    if (placeToPlayer) {
      final cards = switch (player) {
        Player.player1 => player1Cards,
        Player.player2 => player2Cards,
      };
      cards.add(card);
    } else {
      final stash = switch (player) {
        Player.player1 => player1Stash,
        Player.player2 => player2Stash,
      };
      stash.add(card);
    }
  }
}
