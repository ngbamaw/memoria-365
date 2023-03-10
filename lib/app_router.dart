import 'package:auto_route/annotations.dart';
import 'package:memoria/pages/calendar_page.dart';
import 'package:memoria/pages/change_field_user_page.dart';
import 'package:memoria/pages/choice_date.dart';
import 'package:memoria/pages/choice_privacy_page.dart';
import 'package:memoria/pages/daily_question_page.dart';
import 'package:memoria/pages/introduction_page.dart';
import 'package:memoria/pages/login_page.dart';
import 'package:memoria/pages/register_page.dart';
import 'package:memoria/pages/response_history_page.dart';
import 'package:memoria/pages/response_list_page.dart';
import 'package:memoria/pages/response_page.dart';
import 'package:memoria/pages/settings_page.dart';
import 'package:memoria/pages/subscription_page.dart';
import 'package:memoria/route_guard.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: IntroductionPage, initial: true),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SubscriptionPage, guards: [AuthGuard]),
    AutoRoute(page: ChoiceDatePage, guards: [AuthGuard]),
    AutoRoute(page: CalendarPage, guards: [AuthGuard]),
    AutoRoute(page: DailyQuestionPage, guards: [AuthGuard]),
    AutoRoute(page: ChoicePrivacyPage, guards: [AuthGuard]),
    AutoRoute(page: ResponseListPage, guards: [AuthGuard]),
    AutoRoute(page: ResponsePage, guards: [AuthGuard]),
    AutoRoute(page: ResponseHistoryPage, guards: [AuthGuard]),
    AutoRoute(page: SettingsPage, guards: [AuthGuard]),
    AutoRoute(page: ChangeFieldUserPage, guards: [AuthGuard]),
  ],
)
class $AppRouter {}