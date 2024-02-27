class FarmerMain {
  String name;
  String password;
  String area;
  String phNumber;
  String status;
  String cropType;

  FarmerMain(
      {required this.name,
      required this.password,
      required this.area,
      required this.phNumber,
      required this.status,
      required this.cropType,
      });
}
class Farmer {
  final int id;
  final String name;
  final String status;
  final String lastProduction;

  Farmer({
    required this.id,
    required this.name,
    required this.status,
    required this.lastProduction,
  });
}

class Production {
  final int id;
  final DateTime date;
  final double quantity;

  Production({
    required this.id,
    required this.date,
    required this.quantity,
  });
}
