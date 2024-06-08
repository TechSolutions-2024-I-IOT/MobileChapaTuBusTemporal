import 'package:chapa_tu_bus_app/account_management/presentation/bloc/auth/auth_bloc.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/auth/login_or_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch an event to check the user's authentication status.
    context.read<AuthBloc>().add(AuthCheckRequested());
    BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      print('Current state in BlocBuilder: $state');
      return Center(child: Text('Current state: $state')); // Print the state
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          print('Authenticated user: $state'); // Print the authenticated user
          context.go('/home/0');
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              print('$state');
              // Show a loading indicator while checking authentication status.
              return const Center(child: CircularProgressIndicator());
            } else if (state is UnAuthenticated) {
              // Show the login/registration screen if unauthenticated.
              print('$state');
              return const LogInOrRegisterScreen();
            } else if (state is AuthError) {
              // Show an error message if authentication check fails.
              print('$state');
              return Center(child: Text(state.message));
            } else {
              // Show a placeholder widget for other states.
              print('$state');
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}