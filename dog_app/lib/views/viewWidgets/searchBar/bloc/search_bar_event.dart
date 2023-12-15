part of 'search_bar_bloc.dart';

sealed class SearchBarEvent extends Equatable {
  const SearchBarEvent();

  @override
  List<Object> get props => [];
}

class ActivateEvent extends SearchBarEvent {}

class DeactivateEvent extends SearchBarEvent {}

class FullSizeEvent extends SearchBarEvent {}



