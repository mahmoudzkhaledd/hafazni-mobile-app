part of 'plans_page_cubit.dart';

@immutable
sealed class PlansPageState {}

final class PlansPageInitial extends PlansPageState {}

class PlansPageLoading extends PlansPageState {}

class PlansPageLoaded extends PlansPageState {
  final List<Plan> plans;
  PlansPageLoaded(this.plans);
}

class PlansPageFailed extends PlansPageState {}
