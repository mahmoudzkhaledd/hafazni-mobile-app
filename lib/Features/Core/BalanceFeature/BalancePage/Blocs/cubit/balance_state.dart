part of 'balance_cubit.dart';

@immutable
sealed class BalanceState {}

final class BalanceInitial extends BalanceState {}

class BalanceLoadingState extends BalanceState {}

class BalanceLoadedState extends BalanceState {}

class BalanceFailedState extends BalanceState {}

class CreateWalletState extends BalanceState {}
