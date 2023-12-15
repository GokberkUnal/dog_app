import 'package:dog_app/models/viewModels/dog_breed_view_model.dart';
import 'package:dog_app/views/viewWidgets/dogPopUp/bloc/dog_popup_dialog_bloc.dart';
import 'package:dog_app/views/viewWidgets/dogPopUp/dog_popup_dialog.dart';
import 'package:dog_app/views/viewWidgets/searchBar/bloc/search_bar_bloc.dart';
import 'package:dog_app/views/viewWidgets/tempWidgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

    homeScreenBlock.add(DeactivateEvent());
    return BlocBuilder<SearchBarBloc, SearchBarState>(
      builder: (context, state) {
        if (state is DeactiveBarState) {
          return deactiveBar(context);
        }
        if (state is ActiveBarState) {
          return activeBar(context);
        }
        if (state is FullSizeBarState) {
          return fullSizeBar(context);
        }
        if (state is SearchingDogStarted) {
          return searchLoading(context);
        }
         if (state is SearchingDogDone) {
          return searchedList(context,state);
        }
         if (state is SearchingDogError) {
          return searchError(context);
        }

        return Container(
          color: Colors.amber,
          width: MediaQuery.of(context).size.width,
        );
      },
    );
  }

  GestureDetector deactiveBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

        homeScreenBlock.add(ActivateEvent());
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 9),
          child: Text(
            "Search",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(60, 60, 67, 0.6000000238418579),
                fontFamily:
                    'assets/fonts/galano-grotesque/Galano Grotesque.otf',
                fontSize: 16,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
      ),
    );
  }

  GestureDetector activeBar(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy > sensitivity) {
          print("aa");
          final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

          homeScreenBlock.add(DeactivateEvent());
        } else if (details.delta.dy < -sensitivity) {
          print("aaa");
          final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

          homeScreenBlock.add(FullSizeEvent());
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: searchBarTextField(context),
        ),
      ),
    );
  }

  GestureDetector fullSizeBar(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy > sensitivity) {
          // Down Swipe
          final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

          homeScreenBlock.add(ActivateEvent());
        } else if (details.delta.dy < -sensitivity) {
          // Up Swipe
        }
      },
      child: Container(
          

        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.73,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.70,
            child: searchBarTextField(context)),
      ),
    );
  }

  GestureDetector searchLoading(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy > sensitivity) {
          // Down Swipe
          final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

          homeScreenBlock.add(DeactivateEvent());
        } else if (details.delta.dy < -sensitivity) {
          // Up Swipe
        }
      },
      child: Container(
          

        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.73,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.70,
            child: LoadingWidget()),
      ),
    );
  }

   GestureDetector searchError(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy > sensitivity) {
          // Down Swipe
          final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

          homeScreenBlock.add(DeactivateEvent());
        } else if (details.delta.dy < -sensitivity) {
          // Up Swipe
        }
      },
      child: Container(
          

        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.73,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.70,
            child: const Text('Error occured',style:   TextStyle(
          color: Color.fromRGBO(60, 60, 67, 0.6000000238418579),
          fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
          fontSize: 16,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.normal,
          height: 1),)),
      ),
    );
  }

  GestureDetector searchedList(BuildContext context, SearchingDogDone state) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy > sensitivity) {
          // Down Swipe
          final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);

          homeScreenBlock.add(DeactivateEvent());
        } else if (details.delta.dy < -sensitivity) {
          // Up Swipe
        }
      },
      child: Container(
          

        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.73,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.70,
            child: Padding(
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
          )),
      ),
    );
  }
  





  TextFormField searchBarTextField(BuildContext context) {
      final TextEditingController _textController = TextEditingController();
    
    return  TextFormField(
      onEditingComplete: ((){
        final homeScreenBlock = BlocProvider.of<SearchBarBloc>(context);
    homeScreenBlock.add(SearchDogEvent(_textController.text));

      }),
    controller: _textController,
      autofocus: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Color.fromRGBO(60, 60, 67, 0.6000000238418579),
          fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
          fontSize: 16,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.normal,
          height: 1),
    );
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
}
