class CreditCard {
  int? id;
  late String title;
  late String name;
  late String number;
  late DateTime date;
  late int cvv;
  late int pin;

  CreditCard({
    this.id,
    required this.title,
    required this.name,
    required this.number,
    required this.date,
    required this.cvv,
    required this.pin,
  });

  CreditCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    number = json['number'];
    date = DateTime.fromMillisecondsSinceEpoch(json['date']);
    cvv = json['cvv'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    // data['id'] = id;
    data['title'] = title;
    data['name'] = name;
    data['number'] = number;
    data['date'] = date.millisecondsSinceEpoch;
    data['cvv'] = cvv;
    data['pin'] = pin;
    return data;
  }
}
