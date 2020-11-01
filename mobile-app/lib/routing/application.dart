import 'package:fluro/fluro.dart';
import 'package:slcovid_tracker/routing/routes.dart';

class Application {
  static FluroRouter router;

  static void initiateRoutes() {
    router = FluroRouter();
    Routes.configureRouter(router);
  }
}
