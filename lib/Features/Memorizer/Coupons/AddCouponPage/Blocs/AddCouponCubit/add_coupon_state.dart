part of 'add_coupon_cubit.dart';

@immutable
sealed class AddCouponState {}

final class AddCouponInitial extends AddCouponState {}

class TryCouponState extends AddCouponState {
  final double? value;
  TryCouponState(this.value);
}

class ChangePercentageState extends AddCouponState {}
class ChangeCouponDateState extends AddCouponState {}
