class Date {
  String Year;
  String Month;
  String Week;

  Date({required this.Year, required this.Month, required this.Week});

  Map<String, dynamic> toJson() {
    return {
      'Year': Year,
      'Month': Month,
      "Week" : Week
    };
  }
}