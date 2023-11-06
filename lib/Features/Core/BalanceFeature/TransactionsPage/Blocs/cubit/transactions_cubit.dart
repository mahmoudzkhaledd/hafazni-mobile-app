import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/Features/Core/BalanceFeature/BalanceServices/BalanceServices.dart';
import 'package:hafazni/Models/Transaction.dart';
import 'package:meta/meta.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(TransactionsLoadingState()) {
    getTransactions();
  }
  final BalanceServices _services = BalanceServices();
  List<Transaction> transactions = [];
  void getTransactions() async {
    transactions.clear();
    emit(TransactionsLoadingState());
    List<Transaction>? trans = await _services.getTransactions();
    if (trans != null) {
      transactions = trans;
      emit(TransactionsLoadedState());
    } else {
      emit(TransactionsFailedState());
    }
  }
}
