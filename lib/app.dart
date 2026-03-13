import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexuspules/core/di/injection.dart';
import 'package:plexuspules/features/profile/presentation/blocs/theme/theme_bloc.dart';
import 'package:plexuspules/features/profile/presentation/blocs/theme/theme_state.dart';

import 'config/theme/app_theme.dart';
import 'config/app_router.dart';

class PlexusPulseApp extends StatelessWidget {
  const PlexusPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeBloc>(),
      child: ScreenUtilInit(
        designSize: const Size(393, 852), // Common standard design size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Plexus Pulse',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: state.themeMode,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
