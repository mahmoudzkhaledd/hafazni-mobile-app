import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/HomeCubit/home_cubit.dart';
import 'HomePageBody.dart';
import 'Widgets/CustomDrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HomeCubit(),
          child: const SafeArea(child: HomePageBody()),
        ),
      ),
    );
  }
}
