import 'dart:typed_data';

import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';

class DogBreedModel {
  Map<String, List<String>> message;
  String status;
  Uint8List? dogImage;

  DogBreedModel({required this.message, required this.status,this.dogImage});

  factory DogBreedModel.fromJson(Map<String, dynamic> json) {
    // 'message' alanındaki alt tür listelerini dönüştürme
    final Map<String, List<String>> convertedMessage = {};
    json['message'].forEach((key, value) {
      if (value is List<dynamic>) {
        // List<dynamic> ise List<String>'e dönüştür
        convertedMessage[key] = value.cast<String>();
      } else {
        // Zaten List<String> ise doğrudan kullan
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

    // Her bir dog breed için dön
    message.forEach((dogBreedName, subBreeds) {
      // DogBreedViewModel oluştur
      DogBreedViewModel viewModel = DogBreedViewModel(
        dogBreedName: dogBreedName,
        dogSubBreedName: subBreeds,
        dogImage: dogImage,
    
      );

      // DogBreedViewModel'ı listeye ekle
      viewModels.add(viewModel);
    });

    return viewModels;
  }
}
