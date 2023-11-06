import 'package:hafazni/Shared/AppReposetory.dart';

class FilterationModel {
  bool get all =>
      countries.isEmpty && rating == 5 && readings.isEmpty && !certificate;
  List<String> countries = [];
  double rating = 5;
  List<int> readings = [];
  bool certificate = false;
  int begin = 0;
  int end = AppRepository.appConfigs.maxSearch;

  String searchText = "";
  void reset() {
    begin = 0;
    end = AppRepository.appConfigs.maxSearch;
  }

  String get requestUrl =>
      "search-memorizers?countries=$countries&maxrating=$rating&readings=$readings&certificate=$certificate&begin=$begin&end=$end&text=$searchText";
}
