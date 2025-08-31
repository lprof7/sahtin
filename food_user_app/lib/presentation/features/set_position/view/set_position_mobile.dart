import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:easy_localization/easy_localization.dart';
import '../viewmodel/set_position_cubit.dart';
import '../viewmodel/set_position_state.dart';
import '../../../../core/routing/app_router.dart';

class SetPositionMobile extends StatelessWidget {
  const SetPositionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setPositionTitle'.tr()),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<SetPositionCubit, SetPositionState>(
        builder: (context, state) {
          if (state is SetPositionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SetPositionError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SetPositionCubit>().initializeLocation();
                    },
                    child: Text('retryButton'.tr()),
                  ),
                ],
              ),
            );
          }

          if (state is SetPositionLoaded) {
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: state.currentPosition,
                          initialZoom: 15,
                          onTap: (_, position) {
                            context
                                .read<SetPositionCubit>()
                                .updateSelectedPosition(position);
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              if (state.selectedPosition != null)
                                Marker(
                                  point: state.selectedPosition!,
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<SetPositionCubit>().setMyLocation();
                          },
                          icon: const Icon(Icons.my_location),
                          label: Text('currentLocationButton'.tr()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed:
                              state.selectedPosition != null
                                  ? () {
                                    context
                                        .read<SetPositionCubit>()
                                        .confirmLocation();
                                  }
                                  : null,
                          icon: const Icon(Icons.check),
                          label: Text('confirmLocationButton'.tr()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'locationInstructions'.tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is SetPositionSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 64, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    'locationSuccess'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'latitude'.tr()}: ${state.confirmedPosition.latitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    '${'longitude'.tr()}: ${state.confirmedPosition.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<SetPositionCubit>().reset();
                        },
                        child: Text('setAnotherLocation'.tr()),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(AppRouter.browseRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('goToApp'.tr()),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
