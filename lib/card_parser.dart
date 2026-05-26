import 'dart:convert';

import 'package:common_entites/common_entites.dart';
import 'package:flutter/services.dart';
import 'package:northern_kingdom/northern_kingdom.dart';

class CardParser {
  static int _id = 0;

  Future<List<SquadCard>> parseConfig() async {
    final rawConfig = await rootBundle.loadString('assets/config/northern_realms_cards_deck.json');
    final config = jsonDecode(rawConfig);
    final squads = config['squad'] as List;

    final cards = squads.cast<Map<String, dynamic>>().map(parse).expand((e) => e).toList();

    return cards;
  }

  List<SquadCard> parse(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final description = json['description'] as String;
    final zones = switch (json['zone'] as String) {
      'Дальний бой' => [CardZone.ranged],
      'Ближний бой' => [CardZone.melee],
      'Осадные' => [CardZone.siege],
      'Ближний бой / Дальний бой' => [CardZone.melee, CardZone.ranged],
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
    final aspect = switch (json['aspect'] as String?) {
      'summon' => GunterAspectSummon(),
      'base' => GunterAspectBase(),
      _ => null,
    };

    if (aspect == null) {
      return null;
    }

    return Sibling(aspect: aspect);
  }
}
