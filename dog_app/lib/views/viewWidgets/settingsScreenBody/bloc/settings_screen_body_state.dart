part of 'settings_screen_body_bloc.dart';

sealed class SettingsScreenBodyState extends Equatable {
  const SettingsScreenBodyState();
  
  @override
  List<Object> get props => [];
}

 class SettingsScreenBodyInitial extends SettingsScreenBodyState {}

class GetOsVersionStarted extends SettingsScreenBodyState {}


class  GetOsVersionDone extends SettingsScreenBodyState {
  final String osVersion;

const GetOsVersionDone(this.osVersion);
}

class  GetOsVersionError extends SettingsScreenBodyState {
  final String error;

  const  GetOsVersionError(this.error);
}

