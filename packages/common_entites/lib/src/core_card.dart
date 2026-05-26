abstract class CoreCard {
  final int id;
  final String name;
  final String description;
  final String? ability;

  const CoreCard({
    required this.id,
    required this.name,
    required this.description,
    required this.ability,
  });
}
