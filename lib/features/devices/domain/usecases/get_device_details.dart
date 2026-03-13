import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/device.dart';
import '../repositories/devices_repository.dart';

@lazySingleton
class GetDeviceDetails {
  final DevicesRepository _repository;

  GetDeviceDetails(this._repository);

  Future<Either<Failure, Device>> call(String id) {
    return _repository.getDeviceDetails(id);
  }
}
