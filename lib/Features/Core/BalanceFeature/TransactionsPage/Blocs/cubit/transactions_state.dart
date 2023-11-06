part of 'transactions_cubit.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsLoadedState extends TransactionsState {}

class TransactionsFailedState extends TransactionsState {}
