part of 'home_screen_body_bloc.dart';

sealed class HomeScreenBodyState extends Equatable {
  const HomeScreenBodyState();
  
  @override
  List<Object> get props => [];
}

final class HomeScreenBodyInitial extends HomeScreenBodyState {}


class GetDogFromCacheStarting extends HomeScreenBodyState {}


class GetDogFromCacheDone extends HomeScreenBodyState {
  final List<DogBreedViewModel> dogBreedViewModel;

const GetDogFromCacheDone(this.dogBreedViewModel);
}

class GetDogFromCacheError extends HomeScreenBodyState {
  final String error;

  const GetDogFromCacheError(this.error);
}








