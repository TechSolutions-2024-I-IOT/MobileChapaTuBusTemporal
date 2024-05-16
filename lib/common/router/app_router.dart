import 'package:chapa_tu_bus_app/account_management/presentation/screens/auth/auth_screen.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/profile/profile_view.dart';
import 'package:chapa_tu_bus_app/common/utils/home/home_screen.dart';
import 'package:chapa_tu_bus_app/common/utils/home/home_view.dart';
import 'package:chapa_tu_bus_app/common/utils/home/start_screen.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/favorites_view.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/line_buses_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/start',
    builder: (context, state) => const StartScreen(),
  ),
  GoRoute(
    path: '/auth',
    builder: (context, state) => const AuthScreen(),
  ),
  GoRoute(
    path: '/home/:pageIndex', // Define la ruta con un parámetro para pageIndex
    builder: (BuildContext context, GoRouterState state) {
      final pageIndex = int.parse(state.pathParameters['pageIndex']!);
      return HomeScreen(pageIndex: pageIndex);
    },
    routes: <GoRoute>[
      GoRoute(
        path: '0',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeView(),
      ),
      GoRoute(
        path: '1',
        builder: (BuildContext context, GoRouterState state) =>
            const LineBusesView(),
      ),
      GoRoute(
        path: '2',
        builder: (BuildContext context, GoRouterState state) =>
            const FavoritesView(),
      ),
      GoRoute(
        path: '3',
        builder: (BuildContext context, GoRouterState state) =>
            const ProfileView(),
      ),
    ],
  ),
  GoRoute(
    path: '/',
    redirect: (context, state) {
      // Verifica si hay un usuario actual de Firebase
      final user = FirebaseAuth.instance.currentUser;

      // Redirige a la pantalla apropiada según el estado de autenticación
      if (user != null) {
        return '/home/0'; // Si hay un usuario, redirige a la pantalla de inicio
      } else {
        return '/start'; // Si no hay usuario, redirige a la pantalla de inicio de sesión
      }
    },
  ),
]);
