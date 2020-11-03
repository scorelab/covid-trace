import 'package:fluro/fluro.dart';
import 'package:slcovid_tracker/routing/route_handlers.dart';

class Routes {
  static const splash = "/";
  static const signin = "/signin";
  static const signup = "/signup";
  static const permission = "/permission";
  static const verification = "/verification";
  static const main = "/main";
  static const history = "/history";
  static const historypossible = "/historypossible";
  static const checkin = "/checkin";
  static const safeentrybeforecheckin = "/safeentrybeforecheckin";
  static const safeentrycheckin = "/safeentrycheckin";
  static const checkout = "/checkout";

  static void configureRouter(FluroRouter router) {
    router.define(splash, handler: splashHandler);
    router.define(signin, handler: signinHandler);
    router.define(signup, handler: signupHandler);
    router.define(permission, handler: permissionHandler);
    router.define(main, handler: mainHandler);
    router.define(verification, handler: verificationHandler);
    router.define(checkin, handler: checkinHandler);
    router.define(safeentrybeforecheckin, handler: safeentrybeforecheckinHandler);
    router.define(safeentrycheckin, handler: safeentrycheckinHandler);
    router.define(checkout, handler: checkoutHandler);
  }
}
