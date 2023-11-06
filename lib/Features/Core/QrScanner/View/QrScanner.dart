import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/QrScanner/Blocs/cubit/qr_code_cubit.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';

import 'Widgets/QrScannerBody.dart';

class QrScanner extends StatelessWidget {
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('كود QR'),
      ),
      body: BlocProvider(
        create: (context) => QrCodeCubit(),
        child: const QrScannerBody(),
      ),
    );
  }
}
