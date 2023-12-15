import 'dart:convert';

import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CacheService {
  static const String _keyDogList = 'dogList';


  Future<void> cacheDogList(List<DogBreedViewModel> dogList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    List<String> serializedList = dogList.map((dog) {
      Map<String, dynamic> dogMap = dog.toMap();
      return json.encode(dogMap);
    }).toList();

   
    prefs.setStringList(_keyDogList, serializedList);
  }

 
  Future<List<DogBreedViewModel>> getCacheDogList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    
    List<String>? serializedList = prefs.getStringList(_keyDogList);
    if (serializedList == null || serializedList.isEmpty) {
      return [];
    }

    List<DogBreedViewModel> dogList = serializedList.map((jsonString) {
      Map<String, dynamic> dogMap = json.decode(jsonString);
      return DogBreedViewModel.fromMap(dogMap);
    }).toList();

    return dogList;
  }
}