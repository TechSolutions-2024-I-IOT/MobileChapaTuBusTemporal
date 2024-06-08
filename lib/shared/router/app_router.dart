import 'package:chapa_tu_bus_app/account_management/infrastructure/data/local_database_datasource.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/bloc/auth/auth_bloc.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/bloc/profile/profile_bloc.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/bloc/settings/settings_bloc.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/auth/auth_screen.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/auth/reset_password_screen.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/profile/profile_general_view.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/screens/profile/settings_view.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/blocs/gps/gps_bloc.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/blocs/location/location_bloc.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/gps_access_screen.dart';
import 'package:chapa_tu_bus_app/public/screens/loading/loading_screen.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/screens/map_screen.dart';
import 'package:chapa_tu_bus_app/injections.dart';
import 'package:chapa_tu_bus_app/public/screens/home/home_screen.dart';
import 'package:chapa_tu_bus_app/public/screens/home/home_view.dart';
import 'package:chapa_tu_bus_app/public/screens/start/start_screen.dart';
import 'package:chapa_tu_bus_app/shared/widgets/search/search_view.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/start',
      builder: (context, state) => const StartScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => serviceLocator<AuthBloc>(),
        child: const AuthScreen(),
      ),
    ),
    GoRoute(
      path: '/home/:pageIndex',
      builder: (BuildContext context, GoRouterState state) {
        final pageIndex = int.parse(state.pathParameters['pageIndex']!);
        return MultiBlocProvider(
          providers: [
            BlocProvider<ProfileBloc>(
              create: (context) => serviceLocator<ProfileBloc>(),
            ),
          ],
          child: HomeScreen(pageIndex: pageIndex),
        );
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
              BlocProvider<ProfileBloc>(
            create: (context) => serviceLocator<ProfileBloc>(),
            child: const ProfileGeneralView(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/home/3/settings',
      builder: (BuildContext context, GoRouterState state) =>
          BlocProvider<SettingsBloc>(
        create: (context) => serviceLocator<SettingsBloc>(),
        child: const SettingsView(),
      ),
    ),
    GoRoute(
      path: '/home/3/payments',
      builder: (BuildContext context, GoRouterState state) =>
          const PaymentsView(),
      routes: [
        GoRoute(
          path: 'add-card',
          builder: (context, state) => const AddCardView(),
        ),
      ],
    ),
    GoRoute(
      path: '/home/3/subscriptions',
      builder: (BuildContext context, GoRouterState state) =>
          const MySubscriptionView(),
      routes: [
        GoRoute(
          path: 'description-plan',
          builder: (BuildContext context, GoRouterState state) =>
              const DescriptionPlanView(),
        ),
        GoRoute(
          path: 'plans-available',
          builder: (BuildContext context, GoRouterState state) =>
              const PlansAvailableView(),
        ),
      ],
    ),
    GoRoute(
      path: '/loading',

      builder: (context, state) => BlocProvider<GpsBloc>(
        create: (context) => GpsBloc(),
        child: const LoadingScreen(),
      ),
    ),

    GoRoute(
      path: '/maps',
      builder: (context, state) => BlocProvider(
        create: (context) => LocationBloc(),
        child: const MapScreen(),
      ),
    ),

    GoRoute(
  path: '/',
  redirect: (context, state) async {
    // Check for both Firebase and backend authentication
    final user = FirebaseAuth.instance.currentUser;
    final token = LocalDatabaseDatasource.instance.getToken();

    if (user != null || await token != null) {
      // User is authenticated (either with Firebase or backend)
      return '/loading';
    } else {
      // User is not authenticated
      return '/start';
    }
  },
),
    GoRoute(
      path: '/auth/reset-password', 
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => serviceLocator<AuthBloc>(),
        child: const ResetPasswordScreen()
      ),
    ),
    GoRoute(
      path: '/gps-access',
      builder: (context, state) => BlocProvider<GpsBloc>(
        create: (context) => GpsBloc(),
        child: const GpsAccessScreen(),
      ),
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
  ],
);
