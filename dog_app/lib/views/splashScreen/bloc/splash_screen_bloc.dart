import 'package:bloc/bloc.dart';

import 'package:dog_app/services/api_service.dart';
import 'package:dog_app/services/cache_service.dart';
import 'package:equatable/equatable.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final ApiService _apiService = ApiService();
  final CacheService _cacheService = CacheService();
  SplashScreenBloc() : super(SplashScreenInitial());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    if (event is GetDogBreedList) {
      yield DogLoading();
      try {
        final dogBreeds = await _apiService.getDogBreedModelView();
        await _cacheService.cacheDogList(dogBreeds);

        yield DogLoaded();
      } catch (error) {

        yield const DogError('Failed to load dog breeds');
      }
    }
  }
}
