import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dog_app/services/api_service.dart';
import 'package:dog_app/views/viewWidgets/homeScreenBody/bloc/home_screen_body_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dog_popup_dialog_event.dart';
part 'dog_popup_dialog_state.dart';

class DogPopupDialogBloc
    extends Bloc<DogPopupDialogEvent, DogPopupDialogState> {
  final ApiService _apiService = ApiService();
  DogPopupDialogBloc() : super(DogPopupDialogInitial());
  @override
  Stream<DogPopupDialogState> mapEventToState(
      DogPopupDialogEvent event) async* {
    if (event is GetRandomDogPhoto) {
      print(event.dogBreedName);
      yield GetRandomDogPhotoStarting();

      try {
        final randomDogPhoto =
            await _apiService.downloadRandomDogImage(event.dogBreedName);
        yield GetRandomDogPhotoDone(randomDogPhoto);
      } catch (error) {
        yield GetRandomDogPhotoError("Failed to load dog photo");
      }
    }
  }
}
