import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeDialoge extends StatelessWidget {
  const QrCodeDialoge({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: SizedBox(
        width: 350,
        child: QrImageView(
          data: data,
          backgroundColor: Colors.white,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Colors.black,
          ),
          embeddedImage: const AssetImage(
            'assets/images/logo.png',
          ),
          embeddedImageStyle: const QrEmbeddedImageStyle(
            size: Size.square(55),
          ),
        ),
      ),
    );
  }
}
