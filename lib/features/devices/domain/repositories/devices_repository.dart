import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/device.dart';

abstract class DevicesRepository {
  Future<Either<Failure, List<Device>>> getDevices({
    String? search,
    String? status,
    int? page,
    int? limit,
  });
  Future<Either<Failure, Device>> getDeviceDetails(String id);
}
