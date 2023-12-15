import 'dart:convert';
import 'dart:typed_data';

class DogBreedViewModel{
String dogBreedName;
List<String> dogSubBreedName;
   Uint8List? dogImage; 


DogBreedViewModel({required this.dogBreedName,required this.dogSubBreedName,required this.dogImage});

  
  static String? encodeUint8List(Uint8List? uint8List) {
    return uint8List != null ? base64Encode(uint8List) : null;
  }


  static Uint8List? decodeUint8List(String? encodedString) {
    return encodedString != null ? base64Decode(encodedString) : null;
  }


  Map<String, dynamic> toMap() {
    return {
      'dogBreedName': dogBreedName,
      'dogSubBreedName': dogSubBreedName,
      'dogImage': encodeUint8List(dogImage),
    };
  }

  factory DogBreedViewModel.fromMap(Map<String, dynamic> map) {
    return DogBreedViewModel(
      dogBreedName: map['dogBreedName'],
      dogSubBreedName: List<String>.from(map['dogSubBreedName']),
      dogImage: decodeUint8List(map['dogImage']),
    );
  }

}