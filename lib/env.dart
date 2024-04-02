import 'package:envify/envify.dart';

@Envify()
abstract class Env {
  static const String url = 'http://192.168.0.107:8080';
}
