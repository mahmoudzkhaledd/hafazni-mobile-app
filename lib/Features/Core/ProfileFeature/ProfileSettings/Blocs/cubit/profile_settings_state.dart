part of 'profile_settings_cubit.dart';

@immutable
sealed class ProfileSettingsState {}

final class ProfileSettingsInitial extends ProfileSettingsState {}

class ChangeImageState extends ProfileSettingsState {
  final XFile? image;
  ChangeImageState(this.image);
}

class ChangeBirthdateSettingsState extends ProfileSettingsState {}
class ChangeCountrySettingsState extends ProfileSettingsState {}
class ChangeGenderSettingsState extends ProfileSettingsState {}
