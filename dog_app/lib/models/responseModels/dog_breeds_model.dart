import 'dart:typed_data';

import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';

class DogBreedModel {
  Map<String, List<String>> message;
  String status;
  Uint8List? dogImage;

  DogBreedModel({required this.message, required this.status, this.dogImage});

  factory DogBreedModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<String>> convertedMessage = {};
    json['message'].forEach((key, value) {
      if (value is List<dynamic>) {
        convertedMessage[key] = value.cast<String>();
      } else {
        convertedMessage[key] = value;
      }
    });

    return DogBreedModel(
      message: convertedMessage,
      status: json['status'],
    );
  }

  List<DogBreedViewModel> toViewModelList() {
    List<DogBreedViewModel> viewModels = [];

    message.forEach((dogBreedName, subBreeds) {
      DogBreedViewModel viewModel = DogBreedViewModel(
        dogBreedName: dogBreedName,
        dogSubBreedName: subBreeds,
        dogImage: dogImage,
      );

      viewModels.add(viewModel);
    });

    return viewModels;
  }
}
