import 'package:flutter/material.dart';

class OrderLoadingWidget extends StatelessWidget {
  const OrderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
