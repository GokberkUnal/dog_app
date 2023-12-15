import 'package:dog_app/views/viewWidgets/settingsScreenBody/bloc/settings_screen_body_bloc.dart';
import 'package:dog_app/views/viewWidgets/tempWidgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
     final homeScreenBlock = BlocProvider.of<SettingsScreenBodyBloc>(context);

    homeScreenBlock.add(GetOsVersion());
    return BlocBuilder<SettingsScreenBodyBloc, SettingsScreenBodyState>(
      builder: (context, state) {
        
       if (state is GetOsVersionDone) {
          return settingListView(state.osVersion) ;
        } else {
          return const LoadingWidget();
        } 
      },
    );
  }

  ListView settingListView(String osVersion) {
    return ListView(
      children:  <Widget>[

        seetingListItem("assets/icons/info_icon.svg","Help","assets/icons/arrowupright_icon.svg"),
          seetingListItem("assets/icons/star_icon.svg","Rate Us","assets/icons/arrowupright_icon.svg"),
            seetingListItem("assets/icons/share_icon.svg","Share with Friends","assets/icons/arrowupright_icon.svg"),
              seetingListItem("assets/icons/document_icon.svg","Terms of Use","assets/icons/arrowupright_icon.svg"),
                seetingListItem("assets/icons/shield_icon.svg","Privacy Policy","assets/icons/arrowupright_icon.svg"),
                  seetingListItem("assets/icons/version_icon.svg","OS Version",osVersion),
      ],
    );
  }

  ListTile seetingListItem(
      String leadingIconPath, String itemTitle, String buttonLeading) {
    return ListTile(
        leading: SvgPicture.asset(leadingIconPath),
        title: Text(
          itemTitle,
          style: const TextStyle(
            fontFamily: 'assets/fonts/galano-grotesque/Galano Grotesque.otf',
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        trailing: buttonLeading == "assets/icons/arrowupright_icon.svg"
            ? SvgPicture.asset("assets/icons/arrowupright_icon.svg",)
            : Text(
                buttonLeading,
                style: const TextStyle(
                    fontFamily:
                        'assets/fonts/galano-grotesque/Galano Grotesque.otf',
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(60, 60, 67, 0.6000000238418579)),
              ));
  }
}
