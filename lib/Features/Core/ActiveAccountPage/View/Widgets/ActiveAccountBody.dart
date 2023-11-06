import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/ActiveAccountPage/Blocs/AccountTypesCubit/account_type_cubit.dart';
import 'package:hafazni/Shared/AccountTypes.dart';
import '../../../../../GeneralWidgets/CustomSliverAppBar.dart';
import '../../../../../Helper/Helper.dart';
import 'AccountTypeWidget.dart';

class ActiveAccountBody extends StatelessWidget {
  const ActiveAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountTypeCubit>();
    return Column(
      children: [
        const CustomSliverAppBar(
          image: 'activeWall.jpg',
          title: "تفعيل الحساب",
          height: 270,
          subTitle:
              'يجب تفعيل حسابك اولا باحدى الانواع الموضحة في الاسفل حتى تتمكن من القيام بانشطة على المنصة',
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => cubit.getAccountTypes(),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                BlocBuilder<AccountTypeCubit, AccountTypeState>(
                  builder: (context, state) {
                    if (state is AccountTypeLoadedState) {
                      return Column(
                        children: [
                          AccountTypeWidget(
                            onTap: cubit.onTapType,
                            description: AccountTypesApi.types['user']!,
                            onSeeReasons: () => cubit.onSeeReasons(true),
                            state: state.userState,
                          ),
                          AccountTypeWidget(
                            onTap: cubit.onTapType,
                            description: AccountTypesApi.types['memorizer']!,
                            onSeeReasons: () => cubit.onSeeReasons(false),
                            state: state.memorizerState,
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(height: 300),
                        Helper.loadingWidget(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
