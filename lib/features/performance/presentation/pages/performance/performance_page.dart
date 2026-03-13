import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/di/injection.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:plexuspules/features/performance/presentation/pages/performance/performance_view.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(const FetchDashboardMetrics()),
      child: const PerformanceView(),
    );
  }
}
