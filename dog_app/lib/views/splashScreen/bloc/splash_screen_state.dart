part of 'splash_screen_bloc.dart';

sealed class SplashScreenState extends Equatable {
  const SplashScreenState();
  
  @override
  List<Object> get props => [];
}

final class SplashScreenInitial extends SplashScreenState {}


class DogLoading extends SplashScreenState {}


class DogLoaded extends SplashScreenState {
}

class DogError extends SplashScreenState {
  final String error;

  const DogError(this.error);
}







