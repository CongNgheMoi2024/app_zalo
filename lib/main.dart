import 'package:app_zalo/routes/route_generate.dart';
import 'package:app_zalo/routes/routes.dart';
import 'package:app_zalo/storages/key_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(KeyStorage.setting);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZAloo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes(),
      initialRoute: RouterName.initScreen,
      navigatorObservers: [MyNavigatorObserver()],
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    RouteGenerate.setSaveRouterName(
        routerName: previousRoute?.settings.name ?? '');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    RouteGenerate.setSaveRouterName(routerName: route.settings.name);
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    RouteGenerate.setSaveRouterName(routerName: newRoute?.settings.name);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}