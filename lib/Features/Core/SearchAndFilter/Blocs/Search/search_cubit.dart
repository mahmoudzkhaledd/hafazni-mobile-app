import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/Models/FilterationMode.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/Service/SearchFilterService.dart';
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/Shared/AppReposetory.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../ProfileFeature/UserProfile/View/UserProfile.dart';
import '../../Service/FilterationDialogs.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(LodingMemorizersState()) {
    search(true);
  }
  List<User> users = [];
  FilterationModel filterationModel = FilterationModel();
  final SearchFilterService _filterService = SearchFilterService();
  final FilterationDialogeService dialogeService = FilterationDialogeService();

  void chooseCountry() async {
    List<String>? res =
        await dialogeService.getCountries(filterationModel.countries);
    if (res != null) {
      filterationModel.countries = res;
      emit(ChangeFiltersState());
    }
  }

  Future<List<User>> search(bool claer) async {
    emit(LodingMemorizersState());
    if (claer) {
      filterationModel.reset();
      users.clear();
    }
    var res = await _filterService.search(filterationModel);
    if (!res.success) {
      emit(FailLodingMemorizersState());
      return [];
    } else {
      final List<User> result = [];

      for (var val in res.data['result']) {
        if (val['userId'] != null) {
          final user = User.fromJsonSearch(val['userId'])
            ..memorizerData = MemorizerData.fromJson(val, true);

          if (claer) {
            users.add(user);
          } else {
            result.add(user);
          }
        }
      }

      emit(LodedMemorizersState());
      return result;
    }
  }

  void showRating() async {
    double? res = await dialogeService.getRating(filterationModel.rating);
    if (res != null) {
      filterationModel.rating = res;
      emit(ChangeFiltersState());
    }
  }

  void showReadings() async {
    List<int>? readings =
        await dialogeService.getReadings(filterationModel.readings);
    if (readings != null) {
      filterationModel.readings = readings;
      emit(ChangeFiltersState());
    }
  }

  void toggtleCertificate() {
    filterationModel.certificate = !filterationModel.certificate;
    emit(ChangeFiltersState());
  }

  void resetFilter() {
    if (!filterationModel.all) {
      filterationModel = FilterationModel();
      emit(ChangeFiltersState());
    }
  }

  void toUserPage(String userId) {
    Get.to(() => UserProfilePage(userId: userId));
  }

  void loadMore(bool top) async {
    int maxLoad = AppRepository.appConfigs.maxLoad;
    int extra = AppRepository.appConfigs.maxSearch;
    if (top) {
      filterationModel.begin -= (extra + users.length);
      filterationModel.end -= (extra + users.length);
      if (filterationModel.begin < 0) {
        filterationModel.begin = 0;
        filterationModel.end = extra;
      }
    } else {
      filterationModel.begin += extra;
      filterationModel.end += extra;
    }

    final List<User> us = await search(false);
    if (us.isEmpty) {
      if (top) {
      } else {
        filterationModel.begin -= extra;
        filterationModel.end -= extra;
      }
    } else {
      if (us.length + users.length <= maxLoad) {
        users.addAll(us);
      } else {
        int remove = (us.length + users.length) - maxLoad;
        if (top) {
          users.removeRange(users.length - remove, users.length);
          users.insertAll(0, us);
          //print(remove);
        } else {
          users.removeRange(0, remove);
          users.addAll(us);
        }
      }
    }
    emit(LodedMemorizersState());
  }
}
