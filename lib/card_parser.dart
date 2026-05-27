import 'dart:convert';

import 'package:common_entites/common_entites.dart';
import 'package:flutter/services.dart';

class CardParser {
  static const nothernKingdomConfig = 'assets/config/northern_realms_cards_deck.json';
  static const monstersConfig = 'assets/config/monsters_cards_deck.json';
  static const nilfgaardianEmpireConfig = 'assets/config/nilfgaardian_empire_cards_deck.json';
  static const scoiaTaelConfig = 'assets/config/scoia_tael_cards_deck.json';

  static int _id = 0;

  Future<Deck> parseDeck(String configPath) async {
    final rawConfig = await rootBundle.loadString(configPath);
    final config = jsonDecode(rawConfig);
    final squads = config['squad'] as List;
    final specials = config['special'] as List;

    final squadCards = squads
        .cast<Map<String, dynamic>>()
        .map(parseSquadCards)
        .expand(
          (e) => e,
        )
        .toList();

    final weatherCards = specials
        .cast<Map<String, dynamic>>()
        .map(parseWeatherCards)
        .expand(
          (e) => e,
        )
        .toList();

    final specialCards = specials
        .cast<Map<String, dynamic>>()
        .map(parseSpecialCards)
        .expand(
          (e) => e,
        )
        .toList();

    final name = config['name'] as String;

    return Deck(
      cards: [
        ...specialCards,
        ...weatherCards,
        ...squadCards,
      ],
      name: name,
    );
  }

  List<SpecialCard> parseSpecialCards(Map<String, dynamic> json) {
    final cardConstructor = switch (json['abilities'] as String) {
      'Казнь' => (int id) => ExcecutionCard(id: id),
      'Командирский рог' => (int id) => CommandersHornCard(id: id),
      _ => null,
    };
    final count = json['count'] as int;

    return List.generate(
      count,
      (index) => cardConstructor?.call(_id++),
    ).nonNulls.toList();
  }

  List<WeatherCard> parseWeatherCards(Map<String, dynamic> json) {
    final cardConstructor = switch (json['abilities'] as String) {
      'Ливень' => (int id) => RainCard(id: id),
      'Мгла' => (int id) => MistCard(id: id),
      'Мороз' => (int id) => FrostCard(id: id),
      'Ясное небо' => (int id) => ShineCard(id: id),
      _ => null,
    };
    final count = json['count'] as int;

    return List.generate(
      count,
      (index) => cardConstructor?.call(_id++),
    ).nonNulls.toList();
  }

  List<SquadCard> parseSquadCards(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final description = json['description'] as String;
    final zones = switch (json['zone'] as String) {
      'Дальний бой' => [CardZone.ranged],
      'Ближний бой' => [CardZone.melee],
      'Осадные' => [CardZone.siege],
      'Ближний бой / Дальний бой' => [CardZone.melee, CardZone.ranged],
      'Ближний бой / Дальний бой / Осадные' => CardZone.values,
      _ => <CardZone>[],
    };
    final strength = json['strength'] as int;
    final ability = json['abilities'] as String?;
    final modifier = switch (ability) {
      'Прилив Сил' => StrengthBurst(),
      'Прочная связь' => StrongConnection(),
      'Казнь' => Execution(),
      'Медик' => Medic(),
      'Шпион' => Spy(),
      'Двойник' => getSibling(json),
      'Командирский рог' => CommandersHorn(),
      'Чучело' => Scarecrow(),
      _ => null,
    };
    final special = switch (json['hero'] as String) {
      'Да' => true,
      _ => false,
    };
    final count = json['count'] as int;

    return List.generate(
      count,
      (index) => SquadCard(
        id: _id++,
        name: name,
        description: description,
        baseStrength: strength,
        special: special,
        availableZones: zones,
        ability: ability,
        modifier: modifier,
      ),
    );
  }

  Sibling? getSibling(Map<String, dynamic> json) {
    final aspect = json['aspect'] as String?;

    if (aspect == null) {
      return null;
    }

    return Sibling(aspect: aspect);
  }
}
