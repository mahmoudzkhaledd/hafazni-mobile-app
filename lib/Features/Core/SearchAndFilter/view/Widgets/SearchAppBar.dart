import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/CustomIconButton.dart';

import '../../../../../GeneralWidgets/CustomSliverAppBar.dart';
import '../../../../../GeneralWidgets/CustomTextBox.dart';
import '../../../../../Helper/Helper.dart';
import '../../../../../Shared/AppColors.dart';
import '../../Blocs/Search/search_cubit.dart';
import 'FiltersWidget.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      foregroundColor: Colors.white,
      expandedHeight: Helper.size(context).height / 2,
      pinned: true,
      toolbarHeight: 90,
      backgroundColor: AppColors.mainColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              width: 60,
              height: 6,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: CustomSliverAppBar(
          padding: 0,
          image: 'search.jpg',
          title: 'محرك البحث',
          subTitle: "",
          height: Helper.size(context).height / 2 + 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextBox(
                        onChanged: (e) => cubit.filterationModel.searchText = e,
                        hintText: "كلمات مفتاحية",
                      ),
                    ),
                    const SizedBox(width: 15),
                    CustomIconButton(
                      icon: Icons.search,
                      verticalPadding: 15,
                      horizontalPadding: 15,
                      backColor: Colors.white.withOpacity(0.8),
                      onTap: () => cubit.search(true),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FiltersWidget(
                      img: null,
                      title: 'الكل',
                      onTap: cubit.resetFilter,
                      selected: cubit.filterationModel.all,
                    ),
                    FiltersWidget(
                      img: 'countries.png',
                      title: 'الدولة',
                      onTap: cubit.chooseCountry,
                      selected: cubit.filterationModel.countries.isNotEmpty,
                    ),
                    FiltersWidget(
                      img: 'rating.png',
                      title: 'التقييم',
                      onTap: cubit.showRating,
                      selected: cubit.filterationModel.rating != 5,
                    ),
                    FiltersWidget(
                      img: 'voice-message.png',
                      title: 'القراءات',
                      onTap: cubit.showReadings,
                      selected: cubit.filterationModel.readings.isNotEmpty,
                    ),
                    FiltersWidget(
                      img: 'certificate.png',
                      title: 'الإجازة',
                      onTap: cubit.toggtleCertificate,
                      selected: cubit.filterationModel.certificate,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
