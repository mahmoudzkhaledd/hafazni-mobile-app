import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/QrScanner/Blocs/cubit/qr_code_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/Helper/Helper.dart';
import 'package:hafazni/Shared/Fonts/FontModel.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QrScannerBody extends StatelessWidget {
  const QrScannerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QrCodeCubit>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            'قرب الكاميرا من الكود',
            style: TextStyle(
              fontFamily: FontFamily.black,
              fontSize: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              cubit.controller.switchCamera();
            },
            icon: const Icon(Icons.camera_rear_outlined),
          ),
          const SizedBox(height: 20),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: Helper.size(context).width * 0.8,
            height: Helper.size(context).width * 0.8,
            child: MobileScanner(
              errorBuilder: (p0, p1, p2) {
                return const Center(
                  child: AppText('حدث خطأ الرجاء اعادة المحاولة'),
                );
              },
              controller: cubit.controller,
              onDetect: cubit.onDetectBarCode,
              overlay: QRScannerOverlay(
                scanAreaSize: Size.square(
                  Helper.size(context).width * 0.9 - 90,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
