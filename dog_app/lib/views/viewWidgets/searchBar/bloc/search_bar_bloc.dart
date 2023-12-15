import 'package:bloc/bloc.dart';
import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';
import 'package:dog_app/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'search_bar_event.dart';
part 'search_bar_state.dart';

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  ApiService _apiService =ApiService();
  SearchBarBloc() : super(SearchBarInitial());

  @override
  Stream<SearchBarState> mapEventToState(SearchBarEvent event) async* {

  
    if (event is ActivateEvent) {
      yield ActiveBarState();
    } else if (event is DeactivateEvent) {
      yield DeactiveBarState();
      
    } else if (event is FullSizeEvent) {
      yield FullSizeBarState();
    }
    if(event is SearchDogEvent){

      yield SearchingDogStarted();
      

        try {
 final dogBreeds = await _apiService.searchBreed(event.dogBreedName);

        yield SearchingDogDone(dogBreeds);
      } catch (error) {
        yield  SearchingDogError('Failed to load dog breeds');
      }

    }
  }
}
