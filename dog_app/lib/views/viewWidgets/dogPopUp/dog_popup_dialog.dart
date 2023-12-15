import 'dart:typed_data';

import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';
import 'package:dog_app/views/splashScreen/bloc/splash_screen_bloc.dart';
import 'package:dog_app/views/viewWidgets/dogPopUp/bloc/dog_popup_dialog_bloc.dart';
import 'package:dog_app/views/viewWidgets/homeScreenBody/bloc/home_screen_body_bloc.dart';
import 'package:dog_app/views/viewWidgets/tempWidgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DogPopupDialog extends StatelessWidget {
  final DogBreedViewModel indexDog;

  const DogPopupDialog(this.indexDog, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dogPopUpDialogContainer(indexDog, context);
  }

  Widget dogPopUpDialogContainer(
      DogBreedViewModel dogBreedViewModel, BuildContext context) {
  
    Widget content = dogInfoCard(indexDog, context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * .75,
        child: Stack(
          children: [
            content,
            Align(
                alignment: Alignment.topRight,
                child: closePopUpButton(context, "assets/icons/xbutton.svg")),
            Align(
                alignment: Alignment.bottomCenter,
                child: generateButton(indexDog, context)),
          ],
        ),
      ),
    );
  }

  Column dogInfoCard(
      DogBreedViewModel dogBreedViewModel, BuildContext context) {
    return Column(
      children: [
        dogPopUpImage(indexDog, context),
        dogInfoTexts(indexDog, context)
      ],
    );
  }

  Container dogPopUpImage(DogBreedViewModel indexDog, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .75 / 2,
      width: MediaQuery.of(context).size.height * .75 / 2,
      child: FittedBox(
          fit: BoxFit.fill,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: indexDog.dogImage!.isNotEmpty
                ? Image.memory(
                    indexDog.dogImage!,
                  )
                : Image.asset(
                    'assets/icons/splash_screen_icon.png',
                  ),
          )),
    );
  }

  Container dogInfoTexts(DogBreedViewModel indexDog, BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.37,
        child: Column(
          children: [
            dogInfoTextTitle("Breed"),
            dogInfoTextDivider(),
            dogInfoTextContent(indexDog.dogBreedName),
            dogInfoTextTitle("Sub Breed"),
            dogInfoTextDivider(),
            subBreedTextContents(context)
          ],
        ));
  }

  Padding dogInfoTextTitle(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromRGBO(0, 84, 211, 1),
            fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
            fontSize: 20,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1),
      ),
    );
  }

  Padding dogInfoTextContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1),
      ),
    );
  }

  Container subBreedTextContents(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.20,
        child: indexDog.dogSubBreedName.isEmpty
            ? dogInfoTextContent("No sub breed")
            : subBreedListview(indexDog));
  }

  ListView subBreedListview(DogBreedViewModel indexDog) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: indexDog.dogSubBreedName.length,
        itemBuilder: (BuildContext context, int index) {
          return dogInfoTextContent(indexDog.dogSubBreedName[index]);
        });
  }

  Container dogInfoTextDivider() {
    return Container(
        width: 280,
        height: 2,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(242, 242, 247, 1),
        ));
  }

  Padding closePopUpButton(BuildContext context, String iconPath) {
    return Padding(
      padding: EdgeInsets.only(top: 4, right: 4),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child:
            SizedBox(width: 32, height: 32, child: SvgPicture.asset(iconPath)),
      ),
    );
  }

  Padding generateButton(
    DogBreedViewModel indexDog,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Color.fromRGBO(0, 132, 255, 1),
          ),
          child: TextButton(
            onPressed: () {
              print("a");

              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return BlocProvider<DogPopupDialogBloc>(
                    create: (context) => DogPopupDialogBloc(),
                    child: randomDogPhotoAlertDialog(
                        context, indexDog.dogBreedName),
                  );
                },
                
              );
            },
            child: const Text(
              "Generate",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Galano Grotesque',
                  fontSize: 18,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          )),
    );
  }

  AlertDialog randomDogPhotoAlertDialog(
      BuildContext context, String dogBreedName) {
    final homeScreenBlock = BlocProvider.of<DogPopupDialogBloc>(context);
    homeScreenBlock.add(GetRandomDogPhoto(indexDog.dogBreedName));
    return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: BlocBuilder<DogPopupDialogBloc, DogPopupDialogState>(
          builder: (context, state) {
            if (state is DogPopupDialogInitial) {
              final homeScreenBlock =
                  BlocProvider.of<DogPopupDialogBloc>(context);
              homeScreenBlock.add(GetRandomDogPhoto(indexDog.dogBreedName));
            }

            if (state is GetRandomDogPhotoStarting) {
              return Container(
                color: Colors.transparent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              );
            }
            if (state is GetRandomDogPhotoDone) {
              print(state.randomDogPhoto);
              return randomDogPhotoContainer(state.randomDogPhoto, context);
            }
            if (state is GetRandomDogPhotoError) {
              return Container(
                color: Colors.transparent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 30, child: Text("Error"))],
                ),
              );
            } else {
              print(state);
              return Container();
            }
          },
        ));
  }

  Widget randomDogPhotoContainer(
      Uint8List? randomDogPhoto, BuildContext context) {
  
    Widget content = SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
            
            child: SizedBox(
                 width: 256,
              height: 256,
              child: FittedBox(
                   fit: BoxFit.fill,
                child: !randomDogPhoto!.isEmpty
                    ? Image.memory(randomDogPhoto!)
                    : Image.asset('assets/icons/splash_screen_icon.png'),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: closePopUpButton(
                  context, "assets/icons/xbutton_square.svg"))
        ],
      ),
    );

    return content; 
  }
}
