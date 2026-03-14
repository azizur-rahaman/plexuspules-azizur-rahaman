import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';

abstract class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object?> get props => [];
}

class FetchDevices extends DevicesEvent {
  const FetchDevices();
}

class RefreshDevices extends DevicesEvent {
  final Completer<void>? completer;
  const RefreshDevices({this.completer});

  @override
  List<Object?> get props => [completer];
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
