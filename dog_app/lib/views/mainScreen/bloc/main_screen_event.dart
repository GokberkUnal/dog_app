part of 'main_screen_bloc.dart';

sealed class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}
class AppStarted extends MainScreenEvent {
  @override
  String toString() => 'AppStarted';
}

class PageTapped extends MainScreenEvent {
  final int index;

  const PageTapped({required this.index});

  @override
  String toString() => 'PageTapped: $index';
}
