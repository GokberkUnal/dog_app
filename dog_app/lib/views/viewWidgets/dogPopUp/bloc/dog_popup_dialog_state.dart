part of 'dog_popup_dialog_bloc.dart';

sealed class DogPopupDialogState extends Equatable {
  const DogPopupDialogState();
  
  @override
  List<Object> get props => [];
}

final class DogPopupDialogInitial extends DogPopupDialogState {}

class GetRandomDogPhotoStarting extends DogPopupDialogState {}


class GetRandomDogPhotoDone extends DogPopupDialogState {
  final Uint8List randomDogPhoto;

const GetRandomDogPhotoDone(this.randomDogPhoto);
}

class GetRandomDogPhotoError extends DogPopupDialogState {
  final String error;

  const GetRandomDogPhotoError(this.error);
}

