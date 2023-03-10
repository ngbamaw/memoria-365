import 'package:auto_route/auto_route.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGuard extends AutoRouteGuard {
  final _supabase = Supabase.instance.client;
  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser != null) return resolver.next();
    
    router.navigate(const LoginRoute());
  }
}