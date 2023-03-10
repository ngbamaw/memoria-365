// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import 'pages/calendar_page.dart' as _i6;
import 'pages/change_field_user_page.dart' as _i13;
import 'pages/choice_date.dart' as _i5;
import 'pages/choice_privacy_page.dart' as _i8;
import 'pages/daily_question_page.dart' as _i7;
import 'pages/introduction_page.dart' as _i1;
import 'pages/login_page.dart' as _i3;
import 'pages/register_page.dart' as _i2;
import 'pages/response_history_page.dart' as _i11;
import 'pages/response_list_page.dart' as _i9;
import 'pages/response_page.dart' as _i10;
import 'pages/settings_page.dart' as _i12;
import 'pages/subscription_page.dart' as _i4;
import 'route_guard.dart' as _i16;

class AppRouter extends _i14.RootStackRouter {
  AppRouter({
    _i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i16.AuthGuard authGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    IntroductionRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.IntroductionPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.LoginPage(
          key: args.key,
          onLoginCallback: args.onLoginCallback,
        ),
      );
    },
    SubscriptionRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SubscriptionPage(),
      );
    },
    ChoiceDateRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ChoiceDatePage(),
      );
    },
    CalendarRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.CalendarPage(
          key: args.key,
          year: args.year,
        ),
      );
    },
    DailyQuestionRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.DailyQuestionPage(),
      );
    },
    ChoicePrivacyRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.ChoicePrivacyPage(),
      );
    },
    ResponseListRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ResponseListPage(),
      );
    },
    ResponseRoute.name: (routeData) {
      final args = routeData.argsAs<ResponseRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ResponsePage(
          key: args.key,
          date: args.date,
        ),
      );
    },
    ResponseHistoryRoute.name: (routeData) {
      final args = routeData.argsAs<ResponseHistoryRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.ResponseHistoryPage(
          key: args.key,
          date: args.date,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.SettingsPage(),
      );
    },
    ChangeFieldUserRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeFieldUserRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.ChangeFieldUserPage(
          key: args.key,
          title: args.title,
          field: args.field,
        ),
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          IntroductionRoute.name,
          path: '/',
        ),
        _i14.RouteConfig(
          RegisterRoute.name,
          path: '/register-page',
        ),
        _i14.RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        _i14.RouteConfig(
          SubscriptionRoute.name,
          path: '/subscription-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          ChoiceDateRoute.name,
          path: '/choice-date-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          CalendarRoute.name,
          path: '/calendar-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          DailyQuestionRoute.name,
          path: '/daily-question-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          ChoicePrivacyRoute.name,
          path: '/choice-privacy-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          ResponseListRoute.name,
          path: '/response-list-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          ResponseRoute.name,
          path: '/response-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          ResponseHistoryRoute.name,
          path: '/response-history-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          SettingsRoute.name,
          path: '/settings-page',
          guards: [authGuard],
        ),
        _i14.RouteConfig(
          ChangeFieldUserRoute.name,
          path: '/change-field-user-page',
          guards: [authGuard],
        ),
      ];
}

/// generated route for
/// [_i1.IntroductionPage]
class IntroductionRoute extends _i14.PageRouteInfo<void> {
  const IntroductionRoute()
      : super(
          IntroductionRoute.name,
          path: '/',
        );

  static const String name = 'IntroductionRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterRoute extends _i14.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i15.Key? key,
    required dynamic Function() onLoginCallback,
  }) : super(
          LoginRoute.name,
          path: '/login-page',
          args: LoginRouteArgs(
            key: key,
            onLoginCallback: onLoginCallback,
          ),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onLoginCallback,
  });

  final _i15.Key? key;

  final dynamic Function() onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i4.SubscriptionPage]
class SubscriptionRoute extends _i14.PageRouteInfo<void> {
  const SubscriptionRoute()
      : super(
          SubscriptionRoute.name,
          path: '/subscription-page',
        );

  static const String name = 'SubscriptionRoute';
}

/// generated route for
/// [_i5.ChoiceDatePage]
class ChoiceDateRoute extends _i14.PageRouteInfo<void> {
  const ChoiceDateRoute()
      : super(
          ChoiceDateRoute.name,
          path: '/choice-date-page',
        );

  static const String name = 'ChoiceDateRoute';
}

/// generated route for
/// [_i6.CalendarPage]
class CalendarRoute extends _i14.PageRouteInfo<CalendarRouteArgs> {
  CalendarRoute({
    _i15.Key? key,
    required int year,
  }) : super(
          CalendarRoute.name,
          path: '/calendar-page',
          args: CalendarRouteArgs(
            key: key,
            year: year,
          ),
        );

  static const String name = 'CalendarRoute';
}

class CalendarRouteArgs {
  const CalendarRouteArgs({
    this.key,
    required this.year,
  });

  final _i15.Key? key;

  final int year;

  @override
  String toString() {
    return 'CalendarRouteArgs{key: $key, year: $year}';
  }
}

/// generated route for
/// [_i7.DailyQuestionPage]
class DailyQuestionRoute extends _i14.PageRouteInfo<void> {
  const DailyQuestionRoute()
      : super(
          DailyQuestionRoute.name,
          path: '/daily-question-page',
        );

  static const String name = 'DailyQuestionRoute';
}

/// generated route for
/// [_i8.ChoicePrivacyPage]
class ChoicePrivacyRoute extends _i14.PageRouteInfo<void> {
  const ChoicePrivacyRoute()
      : super(
          ChoicePrivacyRoute.name,
          path: '/choice-privacy-page',
        );

  static const String name = 'ChoicePrivacyRoute';
}

/// generated route for
/// [_i9.ResponseListPage]
class ResponseListRoute extends _i14.PageRouteInfo<void> {
  const ResponseListRoute()
      : super(
          ResponseListRoute.name,
          path: '/response-list-page',
        );

  static const String name = 'ResponseListRoute';
}

/// generated route for
/// [_i10.ResponsePage]
class ResponseRoute extends _i14.PageRouteInfo<ResponseRouteArgs> {
  ResponseRoute({
    _i15.Key? key,
    required DateTime date,
  }) : super(
          ResponseRoute.name,
          path: '/response-page',
          args: ResponseRouteArgs(
            key: key,
            date: date,
          ),
        );

  static const String name = 'ResponseRoute';
}

class ResponseRouteArgs {
  const ResponseRouteArgs({
    this.key,
    required this.date,
  });

  final _i15.Key? key;

  final DateTime date;

  @override
  String toString() {
    return 'ResponseRouteArgs{key: $key, date: $date}';
  }
}

/// generated route for
/// [_i11.ResponseHistoryPage]
class ResponseHistoryRoute
    extends _i14.PageRouteInfo<ResponseHistoryRouteArgs> {
  ResponseHistoryRoute({
    _i15.Key? key,
    required DateTime date,
  }) : super(
          ResponseHistoryRoute.name,
          path: '/response-history-page',
          args: ResponseHistoryRouteArgs(
            key: key,
            date: date,
          ),
        );

  static const String name = 'ResponseHistoryRoute';
}

class ResponseHistoryRouteArgs {
  const ResponseHistoryRouteArgs({
    this.key,
    required this.date,
  });

  final _i15.Key? key;

  final DateTime date;

  @override
  String toString() {
    return 'ResponseHistoryRouteArgs{key: $key, date: $date}';
  }
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsRoute extends _i14.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: '/settings-page',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i13.ChangeFieldUserPage]
class ChangeFieldUserRoute
    extends _i14.PageRouteInfo<ChangeFieldUserRouteArgs> {
  ChangeFieldUserRoute({
    _i15.Key? key,
    required String title,
    required String field,
  }) : super(
          ChangeFieldUserRoute.name,
          path: '/change-field-user-page',
          args: ChangeFieldUserRouteArgs(
            key: key,
            title: title,
            field: field,
          ),
        );

  static const String name = 'ChangeFieldUserRoute';
}

class ChangeFieldUserRouteArgs {
  const ChangeFieldUserRouteArgs({
    this.key,
    required this.title,
    required this.field,
  });

  final _i15.Key? key;

  final String title;

  final String field;

  @override
  String toString() {
    return 'ChangeFieldUserRouteArgs{key: $key, title: $title, field: $field}';
  }
}
