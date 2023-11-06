import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hafazni/Models/Country.dart';
import 'package:hafazni/Models/Surah.dart';

import '../Models/AppConfigs.dart';

class AppRepository {
  static final List<Surah> suras = [];
  static final List<String> readings = [];
  static late AppConfigs appConfigs;
  static final Map<String, Country> countries = {};
  static Future<void> init() async {
    final String response = await rootBundle.loadString('assets/suras.json');
    final String reads = await rootBundle.loadString('assets/readings.json');
    final data = await json.decode(response);
    final read = await json.decode(reads);
    for (int i = 0; i < data.length; i++) {
      suras.add(Surah.fromJson(data[i], i + 1));
    }
    for (int i = 0; i < read.length; i++) {
      readings.add(read[i].toString());
    }
    await getCountries();
  }

  static Future<void> getCountries() async {
    final String response =
        await rootBundle.loadString('assets/countrycodes.json');
    final data = await json.decode(response);
    for (int i = 0; i < data.length; i++) {
      countries[data[i]['code'].toString()] = Country.fromJson(data[i]);
    }
  }
}
