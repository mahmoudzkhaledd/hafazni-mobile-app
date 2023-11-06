import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Memorizer/PlansService/PlansService.dart';
import 'package:hafazni/Models/Plan.dart';
import 'package:meta/meta.dart';

part 'plans_page_state.dart';

class PlansPageCubit extends Cubit<PlansPageState> {
  final PlanService _planService = PlanService();
  String? userId;
  PlansPageCubit(this.userId) : super(PlansPageLoading()) {
    getPlans();
  }
  void getPlans() async {
    emit(PlansPageLoading());
    var res = await _planService.getUserPlans(userId);
    if (!res.success) {
      emit(PlansPageFailed());
      return;
    }
    List<Plan> plans = [];
    for (var x in res.data) {
      plans.add(Plan.fromJson(x));
    }
    try {
      emit(PlansPageLoaded(plans));
    } catch (ex) {
      emit(PlansPageFailed());
    }
  }
}
