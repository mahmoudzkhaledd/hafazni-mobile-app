part of 'edit_coupon_cubit.dart';

@immutable
sealed class EditCouponState {}

final class EditCouponInitial extends EditCouponState {}

class ChangeEditCouponDateState extends EditCouponState {}
class ChangeEditCouponStateState extends EditCouponState {}
