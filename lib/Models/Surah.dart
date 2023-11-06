class Surah {
  int number = 0;
  String name = "";
  int ayahNumber = 0;
  bool makkah = false;
  Surah();

  Surah.fromJson(Map<String, dynamic> json, this.number) {
    name = json['name'];
    ayahNumber = json['numberOfAyahs'];
    makkah = (json['revelationType'] == "Meccan");
  }
}
