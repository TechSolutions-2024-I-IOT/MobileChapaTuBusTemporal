import 'package:chapa_tu_bus_app/account_management/presentation/screens/auth/auth_screen.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/profile/profile_general_view.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/profile/settings_view.dart';
import 'package:chapa_tu_bus_app/common/utils/home/home_screen.dart';
import 'package:chapa_tu_bus_app/common/utils/home/home_view.dart';
import 'package:chapa_tu_bus_app/common/utils/home/start_screen.dart';
import 'package:chapa_tu_bus_app/common/utils/search/search_view.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/favorites_view.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/line_bus_detail_view.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/line_buses_view.dart';
import 'package:chapa_tu_bus_app/subscriptions/presentation/screens/add_card_view.dart';
import 'package:chapa_tu_bus_app/subscriptions/presentation/screens/description_plan_view.dart';
import 'package:chapa_tu_bus_app/subscriptions/presentation/screens/my_subscription_view.dart';
import 'package:chapa_tu_bus_app/subscriptions/presentation/screens/payments_view.dart';
import 'package:chapa_tu_bus_app/subscriptions/presentation/screens/plans_available_view.dart';
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
    path: '/home/:pageIndex',
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
            const ProfileGeneralView(),
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
  GoRoute(
      path: '/home/3/settings',
      builder: (BuildContext context, GoRouterState state) =>
          const SettingsView()),
  GoRoute(
    path: '/home/3/payments',
    builder: (context, state) => const PaymentsView(),
    routes: [
      GoRoute(
          path: 'add-card', builder: (context, state) => const AddCardView()),
    ],
  ),
  GoRoute(
    path: '/home/3/subscriptions',
    builder: (context, state) => const MySubscriptionView(),
    routes: [
      GoRoute(
          path: 'description-plan',
          builder: (context, state) => const DescriptionPlanView()),
      GoRoute(
        path: 'plans-available',
        builder: (context, state) => const PlansAvailableView(),
      ),
    ],
  ),
  GoRoute(
    path: '/home/0/search',
    builder: (context, state) => const SearchView(),
  ),
  GoRoute(
    path: '/home/1/line/:lineId',
    pageBuilder: (context, state) {
      final lineId = int.parse(state.pathParameters['lineId'] ?? '0');

      return MaterialPage(
        key: state.pageKey,
        child: LineBusDetailView(lineId: lineId),
      );
    },
  ),
]);
