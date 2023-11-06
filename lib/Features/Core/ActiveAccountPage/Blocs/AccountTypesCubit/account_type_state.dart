
part of 'account_type_cubit.dart';
@immutable
sealed class AccountTypeState {}

final class AccountTypeInitial extends AccountTypeState {}

class AccountTypeLoadingState extends AccountTypeState {}

class AccountTypeLoadedState extends AccountTypeState {
  final accType.AccountTypeState userState;
  final accType.AccountTypeState memorizerState;
  AccountTypeLoadedState({
    required this.userState,
    required this.memorizerState,
  });
}
