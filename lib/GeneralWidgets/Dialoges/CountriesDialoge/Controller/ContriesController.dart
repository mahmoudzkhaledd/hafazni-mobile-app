import 'package:get/get.dart';
import 'package:hafazni/Models/Country.dart';
import 'package:hafazni/Shared/AppReposetory.dart';

class CountriesController extends GetxController {
  CountriesController(List<String> countries, {this.chooseOne = false}) {
    _loadCountries(countries);
  }
  final bool chooseOne;
  void _loadCountries(List<String> countries) async {
    count = AppRepository.countries.values.toList();
    for (var element in countries) {
      selectedCountries[element] = true;
    }
    buildChoises();
    update(['countriedBuilder']);
  }

  late final List<Country> count;
  Map<String, bool> selectedCountries = {};
  List<Country> countryList = [];

  String search = "";
  @override
  void dispose() {
    count.clear();
    super.dispose();
  }

  @override
  void onClose() {
    count.clear();
    super.onClose();
  }

  buildChoises() {
    for (var x in selectedCountries.entries) {
      if (x.value) {
        final a = count.firstWhereOrNull((element) => element.code == x.key);
        if (a != null) {
          countryList.add(a);
        }
      }
    }
  }

  void getCountries() async {
    countryList.clear();
    if (search.isEmpty) {
      buildChoises();
      update(['countriedBuilder']);
      return;
    }
    countryList = count
        .where((element) => element.arabicName.startsWith(search))
        .toList();

    update(['countriedBuilder']);
  }

  void onChanged(String code) {
    if (selectedCountries[code] != true) {
      selectedCountries[code] = true;
    } else {
      selectedCountries.remove(code);
      if (search.isEmpty) {
        countryList.removeWhere((element) => element.code == code);
      }
    }

    update(['countriedBuilder']);
  }

  void clearChoises() {
    selectedCountries.clear();
    countryList.clear();
    update(['countriedBuilder']);
  }

  void done() {
    if (!chooseOne) {
      final List<String> ctries = selectedCountries.keys.map((e) => e).toList();
      Get.back<List<String>>(result: ctries);
    } else {
      Get.back<Country>(result: null);
    }
  }
}
