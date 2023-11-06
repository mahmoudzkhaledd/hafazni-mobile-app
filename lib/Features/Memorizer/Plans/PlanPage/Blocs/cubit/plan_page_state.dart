part of 'plan_page_cubit.dart';

@immutable
sealed class PlanPageState {}

final class PlanPageInitial extends PlanPageState {}

class PlanLoadingState extends PlanPageState {}

class PlanFailedState extends PlanPageState {}

class PlanLoadedState extends PlanPageState {}
