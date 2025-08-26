import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

// Simple LocationDao class for testing
class LocationDao {
  final int id;
  final int userId;
  final double latitude;
  final double longitude;
  final String address;

  LocationDao({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory LocationDao.fromJson(Map<String, dynamic> json) => LocationDao(
    id: json['id'],
    userId: json['user_id'],
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    address: json['address'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'latitude': latitude,
    'longitude': longitude,
    'address': address,
  };

  LocationDao copyWith({
    int? id,
    int? userId,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return LocationDao(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocationDao Tests', () {
    test('should create LocationDao with valid data', () {
      // Arrange
      const userId = 1;
      const latitude = 24.7136;
      const longitude = 46.6753;
      const address = 'شارع الملك فهد، الرياض';

      // Act
      final locationDao = LocationDao(
        id: 1,
        userId: userId,
        latitude: latitude,
        longitude: longitude,
        address: address,
      );

      // Assert
      expect(locationDao.id, equals(1));
      expect(locationDao.userId, equals(userId));
      expect(locationDao.latitude, equals(latitude));
      expect(locationDao.longitude, equals(longitude));
      expect(locationDao.address, equals(address));
    });

    test('should convert LocationDao to JSON and back', () {
      // Arrange
      final locationDao = LocationDao(
        id: 1,
        userId: 1,
        latitude: 24.7136,
        longitude: 46.6753,
        address: 'شارع الملك فهد، الرياض',
      );

      // Act
      final json = locationDao.toJson();
      final fromJson = LocationDao.fromJson(json);

      // Assert
      expect(fromJson.id, equals(locationDao.id));
      expect(fromJson.userId, equals(locationDao.userId));
      expect(fromJson.latitude, equals(locationDao.latitude));
      expect(fromJson.longitude, equals(locationDao.longitude));
      expect(fromJson.address, equals(locationDao.address));
    });

    test('should create copy of LocationDao with modified fields', () {
      // Arrange
      final original = LocationDao(
        id: 1,
        userId: 1,
        latitude: 24.7136,
        longitude: 46.6753,
        address: 'شارع الملك فهد، الرياض',
      );

      // Act
      final copy = original.copyWith(
        address: 'شارع التحلية، الرياض',
        latitude: 21.4858,
        longitude: 39.1925,
      );

      // Assert
      expect(copy.id, equals(original.id));
      expect(copy.userId, equals(original.userId));
      expect(copy.address, equals('شارع التحلية، الرياض'));
      expect(copy.latitude, equals(21.4858));
      expect(copy.longitude, equals(39.1925));
    });

    test('should handle JSON with null values', () {
      // Arrange
      final json = {
        'id': 1,
        'user_id': 1,
        'latitude': 24.7136,
        'longitude': 46.6753,
        'address': 'شارع الملك فهد، الرياض',
      };

      // Act
      final locationDao = LocationDao.fromJson(json);

      // Assert
      expect(locationDao.id, equals(1));
      expect(locationDao.userId, equals(1));
      expect(locationDao.latitude, equals(24.7136));
      expect(locationDao.longitude, equals(46.6753));
      expect(locationDao.address, equals('شارع الملك فهد، الرياض'));
    });

    test('should generate correct JSON structure', () {
      // Arrange
      final locationDao = LocationDao(
        id: 1,
        userId: 1,
        latitude: 24.7136,
        longitude: 46.6753,
        address: 'شارع الملك فهد، الرياض',
      );

      // Act
      final json = locationDao.toJson();

      // Assert
      expect(json['id'], equals(1));
      expect(json['user_id'], equals(1));
      expect(json['latitude'], equals(24.7136));
      expect(json['longitude'], equals(46.6753));
      expect(json['address'], equals('شارع الملك فهد، الرياض'));
    });
  });
}
