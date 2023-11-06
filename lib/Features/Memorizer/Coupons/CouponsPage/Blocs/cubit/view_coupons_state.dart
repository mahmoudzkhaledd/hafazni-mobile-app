part of 'view_coupons_cubit.dart';

@immutable
sealed class ViewCouponsState {}

final class CouponsLoadingState extends ViewCouponsState {}

final class CouponsLoadedState extends ViewCouponsState {
  final List<PromoCode> promoCodes;
  CouponsLoadedState(this.promoCodes);
}
final class CouponsFailState extends ViewCouponsState {}
