import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/app_routes.dart';
import '../../../login/presentation/bloc/login_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          String userName = "Guest";
          String userId = "--";
          String userPhoto = "";

          if (state is AuthSuccess) {
            userName = state.user.name ?? "User";
            userId = state.user.uid;
            userPhoto = state.user.photo ?? "";
          }

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50, bottom: 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF7ED957)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userPhoto),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID : $userId',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.grey),
                title: const Text('Log out'),
                // onTap: () {
                //   Navigator.pop(context);
                //   context.read<AuthBloc>().add(LogoutRequested());
                // },
                onTap: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(LogoutRequested());
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                    AppRoutes.login,
                        (route) => false,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
