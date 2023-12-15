part of 'splash_screen_bloc.dart';

sealed class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
  
}

class GetDogBreedList extends SplashScreenEvent{}

class DownloadDogImages extends SplashScreenEvent{}





