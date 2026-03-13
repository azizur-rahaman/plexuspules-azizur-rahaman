import 'package:equatable/equatable.dart';
import 'package:plexuspules/features/monitoring/domain/entities/device.dart';

abstract class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object?> get props => [];
}

class FetchDevices extends DevicesEvent {
  const FetchDevices();
}

class LoadMoreDevices extends DevicesEvent {
  const LoadMoreDevices();
}

class ChangeFilter extends DevicesEvent {
  final DeviceStatus? status;
  const ChangeFilter(this.status);

  @override
  List<Object?> get props => [status];
}

class SearchChanged extends DevicesEvent {
  final String search;
  const SearchChanged(this.search);

  @override
  List<Object?> get props => [search];
}
