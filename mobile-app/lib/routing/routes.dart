import 'package:fluro/fluro.dart';
import 'package:slcovid_tracker/routing/route_handlers.dart';

class Routes {
  static const main = "/";
  static const signin = "/signin";
  static const signup = "/signup";
  static const permission = "/permission";
  static const home = "/home";

  static void configureRouter(FluroRouter router) {
    router.define(main, handler: mainHandler);
    router.define(signin, handler: signinHandler);
    router.define(signup, handler: signupHandler);
    router.define(home, handler: homeHandler);
    router.define(permission, handler: permissionHandler);
  }
}
