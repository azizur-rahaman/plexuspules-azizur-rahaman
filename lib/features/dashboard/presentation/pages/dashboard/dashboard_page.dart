import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/di/injection.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import 'dashboard_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(const FetchDashboardMetrics()),
      child: const DashboardView(),
    );
  }
}
