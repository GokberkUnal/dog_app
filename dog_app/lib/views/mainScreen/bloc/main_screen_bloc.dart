import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';


part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenInitial());

   int currentIndex = 0;

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
      if (event is AppStarted) {
      add(PageTapped(index: currentIndex));
    }
    if (event is PageTapped) {
      currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: currentIndex);
      yield PageLoading();

      if (currentIndex == 0) {
       
        yield const HomeScreenBodyLoaded();
      }
      if (currentIndex == 1) {
        
        yield const SettingsScreenBodyLoaded();
      }
    }
    
  }
}

