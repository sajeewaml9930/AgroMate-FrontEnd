class reseller {
  String name;
  String password;
  String phNumber;
  String cropType;

  reseller({
    required this.name,
    required this.password,
    required this.phNumber,
    required this.cropType,
  });
}

class ResellerDetails {
  final int id;
  final DateTime date;
  final double quantity;
  final double price;

  ResellerDetails({
    required this.id,
    required this.date,
    required this.quantity,
    required this.price,
  });
}
