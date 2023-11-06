import 'package:bloc/bloc.dart';
import 'package:hafazni/Features/Core/OrdersFeature/Services/OrdersService.dart';
import 'package:hafazni/Models/Order.dart';
import 'package:meta/meta.dart';

part 'user_orders_state.dart';

class UserOrdersCubit extends Cubit<UserOrdersState> {
  UserOrdersCubit(this.toMe) : super(UserOrdersInitial()) {
    getOrders();
  }
  final bool toMe;
  final _ordersService = OrdersServices();
  List<Order> sentOrders = [];
  void getOrders() async {
    sentOrders.clear();
    emit(LoadingOrdersState());
    sentOrders = await _ordersService.getSentOrders(toMe);

    emit(LoadedOrdersState());
  }
}
