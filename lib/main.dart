import 'package:dish_categories_app/feature/login/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/route/app_routes.dart';
import 'feature/food_menu/data/datasource/food_remote_datasource.dart';
import 'feature/food_menu/data/repository/food_repository.dart';
import 'feature/food_menu/presentation/bloc/food_bloc.dart';
import 'feature/login/data/repository/auth_repository.dart';
import 'feature/login/presentation/bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider(
          create: (_) =>
              FoodBloc(FoodRepository(FoodRemoteDataSource()))
                ..add(FetchFoodMenu()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
