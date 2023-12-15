part of 'search_bar_bloc.dart';

sealed class SearchBarState extends Equatable {
  const SearchBarState();
  
  @override
  List<Object> get props => [];
}

 class SearchBarInitial extends SearchBarState {}

class DeactiveBarState extends SearchBarState {}

class ActiveBarState extends SearchBarState {}

class FullSizeBarState extends SearchBarState {}