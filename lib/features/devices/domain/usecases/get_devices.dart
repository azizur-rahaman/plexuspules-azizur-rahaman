import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/device.dart';
import '../repositories/devices_repository.dart';

@lazySingleton
class GetDevices {
  final DevicesRepository _repository;

  GetDevices(this._repository);

  Future<Either<Failure, List<Device>>> call(GetDevicesParams params) {
    return _repository.getDevices(
      search: params.search,
      status: params.status,
      page: params.page,
      limit: params.limit,
    );
  }
}

class GetDevicesParams extends Equatable {
  final String? search;
  final String? status;
  final int? page;
  final int? limit;

  const GetDevicesParams({
    this.search,
    this.status,
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [search, status, page, limit];
}
