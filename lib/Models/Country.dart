class Country {
  late final String englishName;
  late final String dialCode;
  late final String code;
  late final String arabicName;
  Country() {
    englishName = "";
    dialCode = "";
    code = "";
    arabicName = "";
  }
  Country.copy(Country c) {
    englishName = c.englishName;
    dialCode = c.dialCode;
    code = c.code;
    arabicName = c.arabicName;
  }

  Country.fromJson(Map<String, dynamic> json) {
    englishName = json['englishName'];
    dialCode = json['dial_code'];
    code = json['code'];
    arabicName = json['arabicName'];
  }
  Map<String, String> toJson() => {
        "englishName": englishName,
        "dialCode": dialCode,
        "code": code,
        "arabicName": arabicName,
      };
}
