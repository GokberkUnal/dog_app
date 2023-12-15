part of 'home_screen_body_bloc.dart';

sealed class HomeScreenBodyEvent extends Equatable {
  const HomeScreenBodyEvent();

  @override
  List<Object> get props => [];
}

class GetDogBreedListFromCache extends HomeScreenBodyEvent{}


