import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/Blocs/Search/search_cubit.dart';
import 'package:hafazni/Features/Core/SearchAndFilter/view/Widgets/SearchResultWidget.dart';
import 'package:hafazni/GeneralWidgets/AppText.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/Image.dart';
import 'package:hafazni/Shared/AppReposetory.dart';

import 'SearchAppBar.dart';
import 'Shimmer.dart';

class SearchAndFilterBody extends StatelessWidget {
  const SearchAndFilterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (e, b) => [
        BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) => current is ChangeFiltersState,
          builder: (context, state) {
            return SearchAppBar();
          },
        )
      ],
      body: Container(
        color: Colors.white,
        child: BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) => current is! ChangeFiltersState,
          builder: (context, state) {
            if (state is LodingMemorizersState) {
              return const ShimmerSearch();
            }
            if (state is LodedMemorizersState) {
              return RefreshIndicator(
                onRefresh: () async => cubit.search(true),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                  itemCount: cubit.users.length + 1,
                  itemBuilder: (context, index) {
                    if (index < cubit.users.length) {
                      return Column(
                        children: [
                          if (index == 0 &&
                              cubit.filterationModel.end >
                                  AppRepository.appConfigs.maxSearch)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                                top: 30,
                              ),
                              child: CustomButton(
                                text: 'تحميل المزيد',
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                onTap: () => cubit.loadMore(true),
                              ),
                            ),
                          SearchResultWidget(
                            user: cubit.users[index],
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: CustomButton(
                          text: 'تحميل المزيد',
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          onTap: () => cubit.loadMore(false),
                        ),
                      );
                    }
                  },
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => cubit.search(true),
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: ListView(
                    shrinkWrap: true,
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CustomImage(
                        'empty-box.png',
                        width: 180,
                      ),
                      AppText(
                        "عذرا حدث خطأ, الرجاء المحاولة مرة اخرى",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
