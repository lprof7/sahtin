import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/models/user.dart';
import '../../../../core/dependency_injection/service_locator.dart';
import 'set_position_state.dart';

class SetPositionCubit extends Cubit<SetPositionState> {
  final AuthenticationRepository _authRepository;

  SetPositionCubit()
    : _authRepository = sl.get<AuthenticationRepository>(),
      super(const SetPositionInitial());

  Future<void> initializeLocation() async {
    emit(const SetPositionLoading());

    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(const SetPositionError('Location permission denied'));
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition();
      final latLng = LatLng(position.latitude, position.longitude);

      emit(
        SetPositionLoaded(
          currentPosition: latLng,
          isLocationPermissionGranted: true,
        ),
      );
    } catch (e) {
      emit(SetPositionError('Failed to get current location: $e'));
    }
  }

  Future<void> setMyLocation() async {
    if (state is! SetPositionLoaded) return;

    final currentState = state as SetPositionLoaded;
    emit(const SetPositionLoading());

    try {
      final position = await Geolocator.getCurrentPosition();
      final latLng = LatLng(position.latitude, position.longitude);

      emit(
        currentState.copyWith(
          currentPosition: latLng,
          selectedPosition: latLng,
        ),
      );
    } catch (e) {
      emit(SetPositionError('Failed to set current location: $e'));
    }
  }

  void updateSelectedPosition(LatLng position) {
    if (state is! SetPositionLoaded) return;

    final currentState = state as SetPositionLoaded;
    emit(currentState.copyWith(selectedPosition: position));
  }

  Future<void> confirmLocation() async {
    if (state is! SetPositionLoaded) return;

    final currentState = state as SetPositionLoaded;
    if (currentState.selectedPosition == null) {
      emit(const SetPositionError('No location selected'));
      return;
    }

    emit(const SetPositionLoading());

    try {
      // Get current user from SharedPreferences
      final prefs = sl.get<SharedPreferences>();
      final userJson = prefs.getString('user');
      if (userJson == null) {
        emit(const SetPositionError('User not found'));
        return;
      }
      final user = User.fromJson(jsonDecode(userJson));
      final String uid = user.uid;

      // Save the selected position using authentication repository
      final result = await _authRepository.setPosition(
        uid: uid,
        xPosition: currentState.selectedPosition!.longitude,
        yPosition: currentState.selectedPosition!.latitude,
      );
      if (result.isSuccess && result.data!) {
        emit(SetPositionSuccess(currentState.selectedPosition!));
      } else {
        emit(SetPositionError('Failed to save location'));
      }
    } catch (e) {
      emit(SetPositionError('Failed to save location: $e'));
    }
  }

  void reset() {
    emit(const SetPositionInitial());
  }

  void goToHome() {
    // This method will be used to navigate to home screen
    // The actual navigation will be handled in the UI layer
    emit(const SetPositionInitial());
  }
}
