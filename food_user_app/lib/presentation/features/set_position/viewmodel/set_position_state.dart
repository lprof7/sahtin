import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class SetPositionState extends Equatable {
  const SetPositionState();

  @override
  List<Object?> get props => [];
}

class SetPositionInitial extends SetPositionState {
  const SetPositionInitial();
}

class SetPositionLoading extends SetPositionState {
  const SetPositionLoading();
}

class SetPositionLoaded extends SetPositionState {
  final LatLng currentPosition;
  final LatLng? selectedPosition;
  final bool isLocationPermissionGranted;

  const SetPositionLoaded({
    required this.currentPosition,
    this.selectedPosition,
    required this.isLocationPermissionGranted,
  });

  @override
  List<Object?> get props => [
    currentPosition,
    selectedPosition,
    isLocationPermissionGranted,
  ];

  SetPositionLoaded copyWith({
    LatLng? currentPosition,
    LatLng? selectedPosition,
    bool? isLocationPermissionGranted,
  }) {
    return SetPositionLoaded(
      currentPosition: currentPosition ?? this.currentPosition,
      selectedPosition: selectedPosition ?? this.selectedPosition,
      isLocationPermissionGranted:
          isLocationPermissionGranted ?? this.isLocationPermissionGranted,
    );
  }
}

class SetPositionError extends SetPositionState {
  final String message;

  const SetPositionError(this.message);

  @override
  List<Object?> get props => [message];
}

class SetPositionSuccess extends SetPositionState {
  final LatLng confirmedPosition;

  const SetPositionSuccess(this.confirmedPosition);

  @override
  List<Object?> get props => [confirmedPosition];
}
