import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dog_app/models/responseModels/dog_breeds_model.dart';

import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<DogBreedViewModel>> getDogBreedModelView() async {
    List<DogBreedViewModel> dogBreedViewModeList = [];
    try {
      final response = await _dio.get('https://dog.ceo/api/breeds/list/all');
      final dogBreedModel = DogBreedModel.fromJson(response.data);

      for (var entry in dogBreedModel.message.entries) {
        final dogBreedName = entry.key;

        final dogImage = await downloadRandomDogImage(dogBreedName);

        dogBreedViewModeList.add(DogBreedViewModel(
            dogBreedName: dogBreedName,
            dogSubBreedName: entry.value,
            dogImage: dogImage));
        entry.value.forEach((element) {
          print("x" + element);
        });
      }

      return dogBreedViewModeList;
    } catch (error) {
      throw Exception('Failed to load dog breeds');
    }
  }

  Future<String> _fetchDogImageUrl(String dogName) async {
    try {
      final response =
          await Dio().get("https://dog.ceo/api/breed/$dogName/images/random");

      if (response.statusCode == 200) {
        final message = response.data['message'];
        return message;
      } else {
        throw Exception('Failed to load message');
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<Uint8List> _downloadDogImage(String url) async {
    await Future.delayed(const Duration(
        milliseconds: 20)); // Örnek olarak her istek arasında 1 saniye bekleme
    try {
      Dio dio = Dio();
      Response<List<int>> response = await dio.get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));
      return Uint8List.fromList(response.data!);
    } catch (e) {
      return Uint8List(0);
    }
  }

  /*   static Future<Uint8List> _downloadErrorImage() async {
     await Future.delayed(Duration(milliseconds:  20)); 
      
    try {
      Dio dio = Dio();
      Response<List<int>> response = await dio.get<List<int>>("https://upload.wikimedia.org/wikipedia/commons/5/50/Black_colour.jpg",
          options: Options(responseType: ResponseType.bytes));
          log(Uint8List.fromList(response.data!).toString());
      return Uint8List.fromList(response.data!);
    } catch (e) {
      
      throw Exception("Error downloading image: $e");
    } 


   
  }*/

  Future<Uint8List> downloadRandomDogImage(String dogBreedName) async {
    final dogImageUrl = await _fetchDogImageUrl(dogBreedName);
    print(dogImageUrl);

    final dogImage = await downloadDogImageInBackground(dogImageUrl);

    return dogImage;
  }

  Future<Uint8List> downloadDogImageInBackground(String dogName) async {
    return await compute(_downloadDogImage, dogName);
  }

  Future<List<DogBreedViewModel>> searchBreed(String breedName) async {
    List<DogBreedViewModel> dogBreedViewModeList = [];

    try {
      Response response =
          await _dio.get("https://dog.ceo/api/breed/$breedName/list");

      if (response.statusCode == 200) {
        Map<String, dynamic> subBreedsData = response.data;
        List<String> messageList = List<String>.from(subBreedsData['message']);
        Uint8List dogImage = await downloadRandomDogImage(breedName);

        dogBreedViewModeList.add(DogBreedViewModel(
            dogBreedName: breedName,
            dogSubBreedName: messageList,
            dogImage: dogImage));
             
      }
       return dogBreedViewModeList;
    } catch (e) {
      // Dio hatası oluştuysa yakalayın
      print('Error: $e');
        throw Exception('Failed to load dog breeds');
      
    }
  
  }

}
