import 'package:envify/envify.dart';

@Envify()
abstract class Env {
  static const String url = 'http://192.168.1.185:8080';
}
