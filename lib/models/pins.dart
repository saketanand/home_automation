class Pins {
  final int id;
  final int pin_number;
  final String color;
  final String state;

  Pins({
    this.id,
    this.pin_number,
    this.color,
    this.state,
  });

  factory Pins.fromJson(Map<dynamic, dynamic> jsonData) {
    return Pins(
      id: jsonData['id'],
      pin_number: jsonData['pin_num'],
      color: jsonData['color'],
      state: jsonData['state'],
    );
  }
}
