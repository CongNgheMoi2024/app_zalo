class RouteGenerate {
  static String oldRouteName = '';

  static setSaveRouterName({String? routerName}) {
    if (oldRouteName == routerName) {
      oldRouteName = '';
      return;
    } else {
      oldRouteName = routerName ?? '';
    }
  }
}
