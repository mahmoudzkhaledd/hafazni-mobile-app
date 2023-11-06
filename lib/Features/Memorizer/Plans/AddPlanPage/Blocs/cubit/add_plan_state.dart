part of 'add_plan_cubit.dart';

@immutable
sealed class AddPlanState {}

final class AddPlanInitial extends AddPlanState {}

class AddPreqsState extends AddPlanState {}

class AddPromoCodesState extends AddPlanState {}
