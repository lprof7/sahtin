import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/set_position_cubit.dart';
import '../viewmodel/set_position_state.dart';
import 'set_position_mobile.dart';
import 'set_position_tablet.dart';
import 'set_position_web.dart';

class SetPositionScreen extends StatelessWidget {
  const SetPositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetPositionCubit()..initializeLocation(),
      child: const SetPositionView(),
    );
  }
}

class SetPositionView extends StatelessWidget {
  const SetPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return const SetPositionMobile();
    } else if (screenWidth < 1200) {
      return const SetPositionTablet();
    } else {
      return const SetPositionWeb();
    }
  }
}
