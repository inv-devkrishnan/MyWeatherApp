// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:my_weather_app/src/features/location_change/presentation/pages/set_location_page.dart'
    as _i4;
import 'package:my_weather_app/src/features/login/presentation/pages/login_page.dart'
    as _i2;
import 'package:my_weather_app/src/features/weather_forcast/presentation/pages/home_page.dart'
    as _i1;
import 'package:my_weather_app/src/features/weather_forcast/presentation/pages/permission_page.dart'
    as _i3;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeRouteArgs>(
          orElse: () => HomeRouteArgs(loc: pathParams.optString('loc')));
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(
          key: args.key,
          loc: args.loc,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    PermissionRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PermissionPage(),
      );
    },
    SetLocationRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SetLocationPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i6.Key? key,
    String? loc,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            loc: loc,
          ),
          rawPathParams: {'loc': loc},
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<HomeRouteArgs> page =
      _i5.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.loc,
  });

  final _i6.Key? key;

  final String? loc;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, loc: $loc}';
  }
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PermissionPage]
class PermissionRoute extends _i5.PageRouteInfo<void> {
  const PermissionRoute({List<_i5.PageRouteInfo>? children})
      : super(
          PermissionRoute.name,
          initialChildren: children,
        );

  static const String name = 'PermissionRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SetLocationPage]
class SetLocationRoute extends _i5.PageRouteInfo<void> {
  const SetLocationRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SetLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetLocationRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
