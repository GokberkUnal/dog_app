part of 'main_screen_bloc.dart';

sealed class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

final class MainScreenInitial extends MainScreenState {}

class CurrentIndexChanged extends MainScreenState {
  final int currentIndex;

  const CurrentIndexChanged({required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends MainScreenState {
  @override
  String toString() => 'PageLoading';
}

class HomeScreenBodyLoaded extends MainScreenState {
  const HomeScreenBodyLoaded();
}

class SettingsScreenBodyLoaded extends MainScreenState {
  const SettingsScreenBodyLoaded();
}
