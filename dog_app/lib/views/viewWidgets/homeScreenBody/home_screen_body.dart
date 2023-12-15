import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';
import 'package:dog_app/views/viewWidgets/dogPopUp/bloc/dog_popup_dialog_bloc.dart';
import 'package:dog_app/views/viewWidgets/homeScreenBody/bloc/home_screen_body_bloc.dart';
import 'package:dog_app/views/viewWidgets/dogPopUp/dog_popup_dialog.dart';
import 'package:dog_app/views/viewWidgets/tempWidgets/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenBlock = BlocProvider.of<HomeScreenBodyBloc>(context);

    homeScreenBlock.add(GetDogBreedListFromCache());
    return BlocBuilder<HomeScreenBodyBloc, HomeScreenBodyState>(
      builder: (context, state) {
        if (state is GetDogFromCacheDone) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 15.0, 
                mainAxisSpacing: 15.0, 
              ),
              itemCount: state.dogBreedViewModel.length,
              itemBuilder: (context, index) {
         
                return dogCellButton(state.dogBreedViewModel[index], context);
              },
            ),
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}



InkWell dogCellButton(DogBreedViewModel indexDog, BuildContext context, ) {
  return InkWell(
    child: dogContainer(indexDog, context),
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return BlocProvider(
            create: (BuildContext context) => DogPopupDialogBloc(), // Create a new instance of the bloc
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: DogPopupDialog(indexDog),
            ),
          );
        },
      );
    },
  );
} 


Container dogContainer(DogBreedViewModel indexDog, BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
        color: Color.fromRGBO(242, 242, 247, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    width: MediaQuery.of(context).size.width * 0.35,
    height: MediaQuery.of(context).size.width * 0.35,
    child: Stack(
      children: [
        Align(   alignment: Alignment.center,child:dogContainerImage(indexDog, context),),
        Align(
            alignment: Alignment.bottomLeft,
            child: dogContainerText(indexDog, context))
      ],
    ),
  );
}

ClipRRect dogContainerImage(DogBreedViewModel indexDog, BuildContext context) {
  return ClipRRect(
     borderRadius: BorderRadius.circular(8.0),
    child: SizedBox(
          width: MediaQuery.of(context).size.width  ,
      height: MediaQuery.of(context).size.width ,
      child: FittedBox(
        fit: BoxFit.fill,
          child: SizedBox(
            child: indexDog.dogImage!.isNotEmpty
                ? Image.memory(
                    indexDog.dogImage!,
                  )
                : Image.asset(
                    'assets/icons/splash_screen_icon.png',
                  ),
          )),
    ),
  );
}

Container dogContainerText(DogBreedViewModel indexDog, BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      color: Color.fromRGBO(0, 0, 0, 0.23999999463558197),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Text(indexDog.dogBreedName,
        style: const TextStyle(
          fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(255, 255, 255, 1),
        )),
  );
}



/*ListView.builder(
            itemCount: state.dogBreedViewModel.length,
            itemBuilder: (context, index) {
              final breedName = state.dogBreedViewModel[index].dogBreedName;
              final subBreeds = state.dogBreedViewModel[index].dogSubBreedName;
              return  dogContainer(state.dogBreedViewModel.last, context);
            },
          ); */