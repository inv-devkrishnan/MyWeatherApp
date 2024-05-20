import 'package:auto_route/auto_route.dart';
import 'package:my_weather_app/src/core/routing/guard/auth_guard.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: SetLocationRoute.page),
        AutoRoute(
          page: PermissionRoute.page,
          initial: true,
        )
      ];
}
