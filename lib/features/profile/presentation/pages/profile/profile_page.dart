import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/di/injection.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(FetchNotificationSettings()),
      child: const ProfileView(),
    );
  }
}
