import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';
import 'package:dog_app/services/api_service.dart';

import 'package:dog_app/services/cache_service.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_body_event.dart';
part 'home_screen_body_state.dart';

class HomeScreenBodyBloc
    extends Bloc<HomeScreenBodyEvent, HomeScreenBodyState> {
  final CacheService _cacheService = CacheService();
    final ApiService _apiService = ApiService();
  HomeScreenBodyBloc() : super(HomeScreenBodyInitial());

  @override
  Stream<HomeScreenBodyState> mapEventToState(
      HomeScreenBodyEvent event) async* {
    if (event is GetDogBreedListFromCache) {
      yield GetDogFromCacheStarting();

      try {
        final dogBreedsViewModel = await _cacheService.getCacheDogList();

        yield GetDogFromCacheDone(dogBreedsViewModel);
      } catch (error) {
        yield const GetDogFromCacheError('Failed to load dog breeds');
      }
    }

  }

}
