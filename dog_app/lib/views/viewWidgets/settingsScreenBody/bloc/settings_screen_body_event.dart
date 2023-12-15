part of 'settings_screen_body_bloc.dart';

sealed class SettingsScreenBodyEvent extends Equatable {
  const SettingsScreenBodyEvent();

  @override
  List<Object> get props => [];
}


class GetOsVersion extends SettingsScreenBodyEvent{}
