import 'package:dog_app/views/viewWidgets/searchBar/bloc/search_bar_bloc.dart';
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
          child: searchBarTextField(),
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
            child: searchBarTextField()),
      ),
    );
  }

  TextField searchBarTextField() {
    return const TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(60, 60, 67, 0.6000000238418579),
          fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
          fontSize: 16,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.normal,
          height: 1),
    );
  }
}
