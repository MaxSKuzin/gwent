import 'package:collection/collection.dart';
import 'package:common_entites/common_entites.dart';
import 'package:flutter/material.dart';
import 'package:gwent/card_parser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final a = CardParser();
  final cards = await a.parseDeck(
    CardParser.scoiaTaelConfig,
  );
  runApp(
    MyApp(
      deck: cards,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Deck deck;

  const MyApp({
    super.key,
    required this.deck,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    ),
    home: MyHomePage(
      title: 'Flutter Demo Home Page',
      deck: deck,
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final Deck deck;

  const MyHomePage({
    super.key,
    required this.title,
    required this.deck,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _field = PlayField(
    player1Hand: widget.deck.cards,
    player1Deck: [],
    player2Cards: [
      // ZoltanHivay(id: 10)..zone = CardZone.melee,
      // ZoltanHivay(id: 11)..zone = CardZone.melee,
      // ZoltanHivay(id: 12)..zone = CardZone.melee,
    ],
    player2Hand: [],
    player2Deck: [],
    restoreCard: (stash) async => stash.firstOrNull,
    pickCard: _pickCard,
  );

  @override
  Widget build(BuildContext context) {
    final handCards = _field.player1Hand;
    final deckCards = _field.player1Deck;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: CardZone.values.reversed.map(
                (zone) {
                  final weatherCard = _field.weatherCards.firstWhereOrNull(
                    (element) => element.zone == zone,
                  );
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: Colors.green,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          child: Text(
                            switch (zone) {
                              CardZone.melee => '1',
                              CardZone.ranged => '2',
                              CardZone.siege => '3',
                            },
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 10,
                          color: Colors.amber,
                        ),
                        if (weatherCard != null) ...[
                          CardPreview(
                            card: weatherCard,
                            stength: null,
                          ),
                          Container(
                            height: 90,
                            width: 10,
                            color: Colors.amber,
                          ),
                        ],
                        Expanded(
                          child: CardsZone(
                            cards: _field.player2Cards.where((e) => e.zone == zone).toList(),
                            cardBuilder: (e) => GestureDetector(
                              onTap: () {
                                _field.removeSquadCard(
                                  player: Player.player2,
                                  card: e as SquadCard,
                                );
                                setState(() {});
                              },
                              child: CardPreview(
                                card: e,
                                stength: e is SquadCard
                                    ? e.calcStrength(
                                        field: _field,
                                        player: Player.player2,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Expanded(
            child: Column(
              children: CardZone.values.map(
                (zone) {
                  final weatherCard = _field.weatherCards.firstWhereOrNull(
                    (element) => element.zone == zone,
                  );
                  final isHorned = _field.player1Zones.firstWhereOrNull(
                    (e) => e.zone == zone && e.effects.contains(FieldEffect.boost),
                  );
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: Colors.green,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          child: Text(
                            switch (zone) {
                              CardZone.melee => '1',
                              CardZone.ranged => '2',
                              CardZone.siege => '3',
                            },
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 10,
                          color: Colors.amber,
                        ),
                        if (isHorned != null) ...[
                          const Icon(
                            Icons.houseboat_rounded,
                          ),
                          Container(
                            height: 90,
                            width: 10,
                            color: Colors.amber,
                          ),
                        ],
                        if (weatherCard != null) ...[
                          CardPreview(
                            card: weatherCard,
                            stength: null,
                          ),
                          Container(
                            height: 90,
                            width: 10,
                            color: Colors.amber,
                          ),
                        ],
                        Expanded(
                          child: CardsZone(
                            cards: _field.player1Cards.where((e) => e.zone == zone && e is SquadCard).toList(),
                            cardBuilder: (e) => GestureDetector(
                              onTap: () async {
                                await _field.removeSquadCard(
                                  player: Player.player1,
                                  card: e as SquadCard,
                                );
                                setState(() {});
                              },
                              child: CardPreview(
                                card: e,
                                stength: e is SquadCard
                                    ? e.calcStrength(
                                        field: _field,
                                        player: Player.player1,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...handCards.map(
                  (e) => GestureDetector(
                    onTap: () async {
                      if (e is SquadCard) {
                        await _field.playSquadCard(
                          e,
                          Player.player1,
                          e.availableZones.first,
                        );
                      } else if (e is WeatherCard) {
                        await _field.playWeatherCard(e, Player.player1);
                      } else if (e is SpecialCard) {
                        await _field.playSpecialCard(
                          card: e,
                          player: Player.player1,
                          zone: e.availableZones.first,
                        );
                      }
                      setState(() {});
                    },
                    child: CardPreview(
                      card: e,
                      stength: e is SquadCard ? e.baseStrength : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...deckCards.map(
                  (e) => CardPreview(
                    card: e,
                    stength: e is SquadCard ? e.baseStrength : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<SquadCard?> _pickCard(List<SquadCard> cards) => showDialog<SquadCard>(
    context: context,
    builder: (context) => Dialog(
      child: Row(
        children: cards
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.pop(context, e);
                },
                child: CardPreview(
                  card: e,
                  stength: null,
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}

class CardsZone extends StatelessWidget {
  final List<CoreCard> cards;
  final Widget Function(CoreCard card) cardBuilder;

  const CardsZone({
    super.key,
    required this.cards,
    required this.cardBuilder,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: cards
        .map(
          (e) => cardBuilder(e),
        )
        .toList(),
  );
}

class CardPreview extends StatelessWidget {
  final CoreCard card;
  final int? stength;

  const CardPreview({
    super.key,
    required this.card,
    required this.stength,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    child: Padding(
      padding: const EdgeInsetsGeometry.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(card.name),
          const SizedBox(
            height: 16,
          ),
          // Text(card.description),
          Text(stength.toString()),
        ],
      ),
    ),
  );
}
