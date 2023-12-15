part of 'search_bar_bloc.dart';

sealed class SearchBarEvent extends Equatable {
  const SearchBarEvent();

  @override
  List<Object> get props => [];
}

class ActivateEvent extends SearchBarEvent {}

class DeactivateEvent extends SearchBarEvent {}

class FullSizeEvent extends SearchBarEvent {}

class SearchDogEvent extends SearchBarEvent {
  final String dogBreedName;
  const SearchDogEvent(this.dogBreedName);

  @override
  List<Object> get props => [dogBreedName];
}
