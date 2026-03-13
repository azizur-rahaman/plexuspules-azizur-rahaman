import 'package:equatable/equatable.dart';

abstract class PerformanceEvent extends Equatable {
  const PerformanceEvent();

  @override
  List<Object> get props => [];
}

class FetchPerformanceMetrics extends PerformanceEvent {}
