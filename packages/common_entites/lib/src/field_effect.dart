enum FieldEffect {
  badWeather(0),
  plusOne(1),
  boost(2)
  ;

  final int priority;

  const FieldEffect(this.priority);
}
