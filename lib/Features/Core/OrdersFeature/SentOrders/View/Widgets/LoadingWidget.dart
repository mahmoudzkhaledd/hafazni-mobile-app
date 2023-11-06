import 'package:flutter/material.dart';
import 'package:hafazni/GeneralWidgets/CustomContainer.dart';

class LoadingWidgetOrders extends StatelessWidget {
  const LoadingWidgetOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) => CustomContainer(
        width: double.infinity,
        height: 150,
        marginBottom: 20,
        backColor: Colors.black.withOpacity(0.09),
        borderRadius: 10,
        child: SizedBox(),
      ),
    );
  }
}
