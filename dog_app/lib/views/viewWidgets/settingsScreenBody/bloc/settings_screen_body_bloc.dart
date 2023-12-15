import 'package:bloc/bloc.dart';
import 'package:dog_app/services/native_bridge.dart';
import 'package:equatable/equatable.dart';

part 'settings_screen_body_event.dart';
part 'settings_screen_body_state.dart';

class SettingsScreenBodyBloc
    extends Bloc<SettingsScreenBodyEvent, SettingsScreenBodyState> {
  SettingsScreenBodyBloc() : super(SettingsScreenBodyInitial());

  @override
  Stream<SettingsScreenBodyState> mapEventToState(
      SettingsScreenBodyEvent event) async* {
    if (event is GetOsVersion) {
      yield GetOsVersionStarted();

      try {
        String platformVersion = await NativeBridge.getPlatformVersion();
print(platformVersion);
        yield GetOsVersionDone(platformVersion);
      } catch (error) {
        yield const GetOsVersionError('Failed to get os version');
      }
    }
  }
}
