import 'package:envify/envify.dart';

@Envify()
abstract class Env {
  static const String url = 'http://192.168.1.10:8080';
  // static const String url = 'http://192.168.137.141:8080';
}
