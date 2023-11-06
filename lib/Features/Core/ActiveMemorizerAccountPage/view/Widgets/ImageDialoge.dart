import 'package:flutter/material.dart';
import 'package:hafazni/Helper/Helper.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      //child: Image.file(File(path)),
      backgroundColor: Colors.transparent,
      child: Helper.loadNetworkImage(path, 'empty-box.png'),
    );
  }
}
