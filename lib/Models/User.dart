import 'package:hafazni/Models/AccountType.dart';
import 'package:hafazni/Models/Country.dart';
import 'package:hafazni/Models/Pair.dart';
import 'package:hafazni/Shared/AppReposetory.dart';

class User {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String phone = "";
  bool verifiedEmail = false;
  bool gender = true;
  DateTime birthdate = DateTime.now();
  String wallet = "";
  String profilePic = "";
  UserData? userData;
  Country country = Country();
  MemorizerData? memorizerData;
  String id = "";
  String get fullName => "$firstName. ${lastName.isEmpty ? "" : lastName[0]}";
  User();
  User copy() {
    User user = User();
    user.firstName = firstName;
    user.lastName = lastName;
    user.email = email;
    user.password = password;
    user.verifiedEmail = verifiedEmail;
    user.gender = gender;
    user.birthdate = birthdate;
    user.wallet = wallet;
    user.profilePic = profilePic;
    user.country = Country.copy(country);
    user.id = id;
    user.phone = phone;
    return user;
  }

  User.fromJsonSearch(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePic = json['profilePic'] ?? "";
    country = AppRepository.countries[json['country'].toString()] ?? Country();
  }

  String get getQrCode => 'user $id';
  void getCountry(String country) async {}
  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    phone = json['phone'] ?? "";
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'] ?? "";
    verifiedEmail = json['verifiedEmail'];
    gender = json['gender'];
    profilePic = json['profilePic'] ?? "";
    birthdate = DateTime.parse(json['birthdate'].toString());
    wallet = json['wallet'] ?? "";
    country = AppRepository.countries[json['country']] ?? Country();
    if (json['userData'] != null && json['userData'] is Map<String, dynamic>) {
      userData = UserData.fromJson(json['userData']);
    }
    if (json['memorizerData'] != null &&
        json['memorizerData'] is Map<String, dynamic>) {
      memorizerData = MemorizerData.fromJson(json['memorizerData']);
    }
  }
  Map<String, dynamic> toJsonSignup() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "gender": gender,
        "phone": phone,
        "birthdate": birthdate.toString(),
        "country": country.code,
      };
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['verifiedEmail'] = verifiedEmail;
    data['gender'] = gender;
    data['birthdate'] = birthdate;
    data['wallet'] = wallet;
    data['profilePic'] = profilePic;
    if (userData != null) {
      data['target'] = userData!.toJson();
    } else {
      data['target'] = null;
    }
    // if (memorizeHistory != null) {
    //   data['memorizeHistory'] = memorizeHistory!.toJson();
    // } else {
    //   data['memorizeHistory'] = null;
    // }
    return data;
  }
}

class UserData {
  List<Pair<int, int>> suras = [];
  String notes = "";
  AccountTypeState state = AccountTypeState.unActive;
  String id = "";
  String userId = "";
  UserData();

  AccountTypeState _getAccountType(String s) {
    switch (s) {
      case "saved":
        return AccountTypeState.saved;
      case "pending":
        return AccountTypeState.pending;
      case "accepted":
        return AccountTypeState.accepted;
      case "refused":
        return AccountTypeState.refused;
    }
    return AccountTypeState.unActive;
  }

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    state = _getAccountType(json['state']);
    if (json['target'] != null) {
      for (var element in (json['target']['targets'] as List<dynamic>)) {
        int first = int.parse(element['from'].toString());
        int sec = int.parse(element['to'].toString());
        suras.add(Pair(first, sec));
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "target": suras.map(
          (e) => {
            "from": e.first,
            "to": e.second,
          },
        ),
        "notes": notes,
        "accepted": state.toString(),
      };
}

class MemorizerData {
  String id = "";
  String userId = "";
  String certificant = "";
  double rating = 0;
  bool accountVip = false;
  bool verified = false;
  int doneTasks = 0;
  String describtion = "";
  List<int> readings = [];
  int plansCount = 0;
  List<String> promoCodes = [];
  String refusedReason = "";
  AccountTypeState state = AccountTypeState.unActive;

  AccountTypeState _getAccountType(String s) {
    switch (s) {
      case "save":
        return AccountTypeState.saved;
      case "pending":
        return AccountTypeState.pending;
      case "accepted":
        return AccountTypeState.accepted;
      case "refused":
        return AccountTypeState.refused;
    }
    return AccountTypeState.unActive;
  }

  MemorizerData();
  MemorizerData.fromJson(Map<String, dynamic> json, [bool search = false]) {
    id = json['_id'];
    userId = !search ? json['userId'] : json['userId']['_id'];
    certificant = json['certificant'] ?? "";

    rating = json['rating'] * 1.0;
    accountVip = json['accountVip'];
    verified = json['verified'];
    doneTasks = json['doneTasks'];
    describtion = json['description'] ?? "";
    readings = (json['readings'] as List<dynamic>)
        .map((s) => int.parse(s.toString()))
        .toList();
    plansCount = json['plansCount'];
    if (json['promoCodes'] != null) {
      promoCodes = (json['promoCodes'] as List<dynamic>)
          .map((s) => s.toString())
          .toList();
    }

    state = _getAccountType(json['state']);
    if (state == AccountTypeState.refused) {
      refusedReason = json['refusedReason'] ??
          "لا يوجد سبب معين, الرجاء التواصل مع خدمة العملاء";
    }
  }
}
