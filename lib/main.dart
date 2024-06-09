import 'package:chapa_tu_bus_app/account_management/infrastructure/data/local_database_datasource.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/api/transport_company_api.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/infrastructure/data_sources/location_datasource.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/infrastructure/repositories/location_repository_impl.dart';
import 'package:chapa_tu_bus_app/shared/router/app_router.dart';
import 'package:chapa_tu_bus_app/shared/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'execution_monitoring/presentation/blocs/blocs.dart';
import 'firebase_options.dart';
import './injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  final database = LocalDatabaseDatasource.instance;

  final users = await database.getAllUsers();

  if (users.isEmpty) {
    print('The database is empty.');
  } else {
    print('The database have ${users.length} users.');
  }
  runApp(
    
    MultiBlocProvider(
      providers: [
        Provider<Dio> (create: (_) => Dio()),
        Provider<TransportCompanyApi> (create: (context) => TransportCompanyApi(dio: context.read<Dio>())),
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(
          create: (context) => LocationBloc(
            LocationRepositoryImpl(
              locationDataSource: LocationDataSourceImpl(
                dio: context.read<Dio>(),
              ),
            ),
          ),
        ),
        BlocProvider(create: (context) => MapBloc()),
      ], 
      child: const MainApp()
    )
  );

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'ChapaTuBus',
      theme: AppTheme().getTheme(),
    );
  }
}
