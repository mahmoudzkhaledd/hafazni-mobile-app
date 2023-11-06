import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/Blocs/Search/search_cubit.dart';

import 'Widgets/SearchAndFilterBody.dart';

class SearchAndFilterPage extends StatelessWidget {
  const SearchAndFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SearchCubit(),
        child: const SearchAndFilterBody(),
      ),
    );
  }
}
