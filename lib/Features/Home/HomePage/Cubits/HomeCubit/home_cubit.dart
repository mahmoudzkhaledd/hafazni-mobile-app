import 'package:bloc/bloc.dart';
import 'package:hafazni/Features/Home/HomePage/View/Widgets/HomePageBottomSheet.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void onProfileImageTap() {
    Helper.showBottomSheetWidget(const HomePageBottomSheet());
  }
}
