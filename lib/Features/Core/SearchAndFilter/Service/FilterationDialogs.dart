import 'package:get/get.dart';
import 'package:hafazni/GeneralWidgets/Dialoges/CountriesDialoge/view/CountriesDialoge.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/view/Dialoges/RatingDialoge/View/RatingDialoge.dart';
import '../../../../GeneralWidgets/Dialoges/CountriesDialoge/Controller/ContriesController.dart';
import '../view/Dialoges/RatingDialoge/Controller/RatingDialogeController.dart';
import '../view/Dialoges/ReadingsDialoge/Controller/ReadingsDialogeController.dart';
import '../view/Dialoges/ReadingsDialoge/View/ReadingsDialoge.dart';

class FilterationDialogeService {
  Future<List<String>?> getCountries(List<String> countries) async {
    Get.put(CountriesController(countries));
    List<String>? res = await Get.dialog<List<String>>(const CountryDialoge());
    Get.delete<CountriesController>();
    return res;
  }

  Future<double?> getRating(double rating) async {
    Get.put(RatingDialogeController(rating));
    double? res = await Get.dialog<double>(const RatingDialoge());
    Get.delete<RatingDialogeController>();
    return res;
  }

  Future<List<int>?> getReadings(List<int> readings) async {
    Get.put(ReadingsController(readings));
    List<int>? res = await Get.dialog<List<int>>(const ReadingsDialoge());
    Get.delete<ReadingsController>();
    return res;
  }

  Future<bool> getCertificate() async {
    return false;
  }
}
