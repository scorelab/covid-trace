import 'package:fluro/fluro.dart';
import 'package:slcovid_tracker/routing/route_handlers.dart';

class Routes {
  static const main = "/";
  static const login = "/login";
  static const home = "/home";

  static void configureRouter(FluroRouter router) {
    router.define(main, handler: mainHandler);
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
  }
}
