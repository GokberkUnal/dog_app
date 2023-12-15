import 'package:dog_app/views/mainScreen/bloc/main_screen_bloc.dart';
import 'package:dog_app/views/viewWidgets/homeScreenBody/bloc/home_screen_body_bloc.dart';
import 'package:dog_app/views/viewWidgets/homeScreenBody/home_screen_body.dart';
import 'package:dog_app/views/viewWidgets/settingsScreenBody/bloc/settings_screen_body_bloc.dart';
import 'package:dog_app/views/viewWidgets/settingsScreenBody/settings_screen_body.dart';
import 'package:dog_app/views/viewWidgets/tempWidgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainScreenBloc = BlocProvider.of<MainScreenBloc>(context);

    mainScreenBloc.add(const PageTapped(index: 0));

    return Scaffold(
        appBar: mainScreenAppBar(),
        body: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
            if (state is PageLoading) {
              return const LoadingWidget();
            }
            if (state is HomeScreenBodyLoaded) {
              return BlocProvider(
            create: (context) => HomeScreenBodyBloc(), // İkinci sayfada kullanılacak Bloc'u tanımlayın
            child: const HomeScreenBody(),
          );
            }
            if (state is SettingsScreenBodyLoaded) {
              return BlocProvider(
            create: (context) => SettingsScreenBodyBloc(), // İkinci sayfada kullanılacak Bloc'u tanımlayın
            child: const SettingsScreenBody(),
          );
            }
            return Container();
          },
        ),
         extendBody: true,
        bottomNavigationBar: ClipRRect( borderRadius: const BorderRadius.only(
        topRight: Radius.circular(60),
        topLeft: Radius.circular(60),

      ),child: mainScreenBottomNavigationBar()));
  }
}

AppBar mainScreenAppBar() {
  return AppBar(
     centerTitle: true,
    title: const Text(
      "\$appName",
      style: TextStyle(
        fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

BlocBuilder mainScreenBottomNavigationBar() {
  return BlocBuilder<MainScreenBloc, MainScreenState>(
    builder: (context, state) {
      return BottomNavigationBar(
        currentIndex:
            context.select((MainScreenBloc bloc) => bloc.currentIndex),
        items: <BottomNavigationBarItem>[
          bottomNavigationBarItems(
              "assets/icons/HouseLine.svg", "Home", 0, context),
              
          bottomNavigationBarItems(
              "assets/icons/Wrench.svg", "Settings", 1, context),
        ],
        
        unselectedLabelStyle: bottomNavigationBarLabelTextStyle(0, context),
        selectedLabelStyle: bottomNavigationBarLabelTextStyle(1, context),
        onTap: (index) =>
            context.read<MainScreenBloc>().add(PageTapped(index: index)),
            
      );
    },
  );
}

BottomNavigationBarItem bottomNavigationBarItems(
    String iconPath, String label, int buttonIndex, BuildContext context) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      iconPath,
      color: context.select((MainScreenBloc bloc) =>
          bloc.currentIndex == buttonIndex
              ? const Color.fromRGBO(0, 85, 211, 1)
              : const Color.fromRGBO(0, 0, 0, 1)),
    ),
    label: label,
  );
}

TextStyle bottomNavigationBarLabelTextStyle(
    int buttonIndex, BuildContext context) {
  return TextStyle(
    fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
    fontWeight: FontWeight.w600,
    
    color: context.select((MainScreenBloc bloc) =>
        bloc.currentIndex == buttonIndex
            ? const Color.fromRGBO(0, 85, 211, 1)
            : const Color.fromRGBO(0, 0, 0, 1)),
  );
}
