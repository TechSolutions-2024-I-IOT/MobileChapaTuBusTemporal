import 'package:chapa_tu_bus_app/execution_monitoring/domain/entities/bus.dart';

abstract class BusDataSource {
  Future<List<Bus>> getBusesByUserId({required String token, required int userId});
}
