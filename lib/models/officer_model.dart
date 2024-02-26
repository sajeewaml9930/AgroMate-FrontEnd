class Officer {
  String name;
  String password;
  String phNumber;

  Officer({
    required this.name,
    required this.password,
    required this.phNumber,
  });
 Map<String, dynamic> toJson() {
    return {'name': name, 'password': password, 'ph_number': phNumber};
  }
}

