import 'package:dog_app/views/splashScreen/bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<SplashScreenBloc>(context);
    dogBloc.add(GetDogBreedList());

    return BlocBuilder<SplashScreenBloc, SplashScreenState>(
      builder: (context, state) {
        if (state is DogLoading) {
          return splashScreenBody();
        } else if (state is DogLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
               Navigator.pushNamedAndRemoveUntil(context, '/mainscreen',(Route<dynamic> route) => false);
          });
          return Container();
        } else if (state is DogError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Container splashScreenBody() {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/splash_screen_icon.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const CircularProgressIndicator()
          ],
        ));
  }
}
