part of 'user_orders_cubit.dart';

@immutable
sealed class UserOrdersState {}

final class UserOrdersInitial extends UserOrdersState {}

class LoadingOrdersState extends UserOrdersState {}
class LoadedOrdersState extends UserOrdersState {}
class OrdersFailedState extends UserOrdersState {}
