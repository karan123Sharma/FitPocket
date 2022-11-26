import 'package:video_player_web/video_player_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  VideoPlayerPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
