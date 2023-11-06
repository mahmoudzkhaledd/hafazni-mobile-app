part of 'qr_code_cubit.dart';

@immutable
sealed class QrCodeState {}

final class QrCodeInitial extends QrCodeState {}
class QrCodeDetectCode extends QrCodeState{}