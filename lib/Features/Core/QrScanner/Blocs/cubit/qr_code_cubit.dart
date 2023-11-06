import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hafazni/Features/Memorizer/Plans/PlanPage/View/PlanPage.dart';
import 'package:hafazni/Models/Plan.dart';
import 'package:meta/meta.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../ProfileFeature/UserProfile/View/UserProfile.dart';

part 'qr_code_state.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(QrCodeInitial());
  final controller = MobileScannerController(
    facing: CameraFacing.back,
  );
  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }

  void onDetectBarCode(BarcodeCapture barcodes) {
    
    if (barcodes.barcodes.isEmpty || barcodes.barcodes[0].rawValue == null) {
      return;
    }
    String raw = barcodes.barcodes[0].rawValue!;
    var splt = raw.split(' ');
    if (splt.length != 2 || splt[1].isEmpty) {
      return;
    }
    String type = splt[0];
    String id = splt[1];
    if (type == 'user') {
      Get.off(() => UserProfilePage(userId: splt[1]));
    } else if (type == 'plan') {
      Get.off(() => PlanPage(
            plan: Plan()..id = id,
            goToUserPage: true,
          ));
    }
  }
}
