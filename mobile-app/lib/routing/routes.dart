import 'package:fluro/fluro.dart';
import 'package:slcovid_tracker/routing/route_handlers.dart';

class Routes {
  static const main = "/";
  static const signin = "/signin";
  static const signup = "/signup";
  static const permission = "/permission";
  static const home = "/home";
  static const history = "/history";
  static const upload = "/upload";
  static const profile = "/profile";

  static void configureRouter(FluroRouter router) {
    router.define(main, handler: mainHandler);
    router.define(signin, handler: signinHandler);
    router.define(signup, handler: signupHandler);
    router.define(permission, handler: permissionHandler);
    router.define(home, handler: homeHandler);
    router.define(history, handler: historyHandler);
    router.define(history, handler: uploadHandler);
    router.define(history, handler: profileHandler);
  }
}
