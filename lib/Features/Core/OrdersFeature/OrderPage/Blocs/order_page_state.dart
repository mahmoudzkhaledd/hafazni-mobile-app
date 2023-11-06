part of 'order_page_cubit.dart';

@immutable
sealed class OrderPageState {}

final class OrderPageInitial extends OrderPageState {}

class OrderLoadingState extends OrderPageState {}

class OrderLoadedState extends OrderPageState {}

class OrderFailedState extends OrderPageState {}
