part of 'dog_popup_dialog_bloc.dart';

sealed class DogPopupDialogEvent extends Equatable {
  const DogPopupDialogEvent();

  @override
  List<Object> get props => [];
}

class GetRandomDogPhoto extends DogPopupDialogEvent{
  final String dogBreedName;
  const GetRandomDogPhoto( this.dogBreedName);
  @override
 
  
  List<Object> get props => [dogBreedName];

}
