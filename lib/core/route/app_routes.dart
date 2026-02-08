import 'package:flutter/material.dart';

import '../../feature/food_menu/presentation/pages/food_menu.dart';
import '../../feature/food_menu/presentation/pages/order_summary_page.dart';
import '../../feature/login/presentation/pages/login_page.dart';
import '../../feature/login/presentation/pages/otp_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String otp = '/otp';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case home:
        return MaterialPageRoute(builder: (_) => const FoodMenuScreen());

      case cart:
        return MaterialPageRoute(builder: (_) => const OrderSummaryScreen());

      case otp:
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => OtpPage(verificationId: verificationId),
        );

      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
