import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_bar_event.dart';
part 'search_bar_state.dart';

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  SearchBarBloc() : super(SearchBarInitial());

  @override
  Stream<SearchBarState> mapEventToState(SearchBarEvent event) async* {

    if(event is SearchBarInitial ){
      yield DeactiveBarState();

    }
    if (event is ActivateEvent) {
      yield ActiveBarState();
    } else if (event is DeactivateEvent) {
      yield DeactiveBarState();
      
    } else if (event is FullSizeEvent) {
      yield FullSizeBarState();
    }
  }
}
