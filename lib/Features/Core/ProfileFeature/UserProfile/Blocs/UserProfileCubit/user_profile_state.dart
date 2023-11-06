part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}


class UserLoadingState extends UserProfileState {}

class UserLoadedState extends UserProfileState {}

class UserFailedState extends UserProfileState {}
