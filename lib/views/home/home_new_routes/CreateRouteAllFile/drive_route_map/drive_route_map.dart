import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'dart:ui' as ui; // ✅ Added

class DriveRouteMap extends StatefulWidget {
  const DriveRouteMap({super.key});

  @override
  State<DriveRouteMap> createState() => _DriveRouteMapState();
}

class _DriveRouteMapState extends State<DriveRouteMap>
    with SingleTickerProviderStateMixin {
  MaplibreMapController? _mapController;

  double _vehicleLat = 23.8103;
  double _vehicleLng = 90.4125;
  double _vehicleBearing = 0.0;
  double _targetBearing = 0.0;

  double? _previousLat;
  double? _previousLng;

  Symbol? _vehicleSymbol;
  Line? _routeLine;
  List<Symbol> _poiSymbols = [];

  bool _isTracking = true;

  FlutterTts _flutterTts = FlutterTts();

  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  final List<Map<String, dynamic>> _routeWaypoints = [
    {'lat': 23.8103, 'lng': 90.4125, 'instruction': 'Starting point'},
    {'lat': 23.8150, 'lng': 90.4180, 'instruction': 'Continue straight'},
    {'lat': 23.8200, 'lng': 90.4250, 'instruction': 'Destination reached'},
  ];

  final List<Map<String, dynamic>> _pointsOfInterest = [
    {
      'name': 'Gas Station',
      'lat': 23.8110,
      'lng': 90.4130,
      'color': Colors.red,
    },
    {'name': 'Rest Area', 'lat': 23.8135, 'lng': 90.4165, 'color': Colors.blue},
    {
      'name': 'Truck Stop',
      'lat': 23.8160,
      'lng': 90.4195,
      'color': Colors.orange,
    },
    {
      'name': 'Restaurant',
      'lat': 23.8175,
      'lng': 90.4210,
      'color': Colors.green,
    },
    {
      'name': 'Weighing Station',
      'lat': 23.8190,
      'lng': 90.4235,
      'color': Colors.purple,
    },
    {
      'name': 'Port of Entry',
      'lat': 23.8195,
      'lng': 90.4245,
      'color': Colors.teal,
    },
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
    _initTTS();
    _requestPermission();
  }

  Future<void> _initTTS() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  double _calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    final dLon = (lon2 - lon1) * math.pi / 180;
    final y = math.sin(dLon) * math.cos(lat2 * math.pi / 180);
    final x =
        math.cos(lat1 * math.pi / 180) * math.sin(lat2 * math.pi / 180) -
        math.sin(lat1 * math.pi / 180) *
            math.cos(lat2 * math.pi / 180) *
            math.cos(dLon);
    final bearing = math.atan2(y, x) * 180 / math.pi;
    return (bearing + 360) % 360;
  }

  void _updateBearing(double newBearing) {
    double diff = newBearing - _vehicleBearing;
    if (diff > 180)
      diff -= 360;
    else if (diff < -180)
      diff += 360;
    _targetBearing = _vehicleBearing + diff;
    _rotationAnimation =
        Tween<double>(begin: _vehicleBearing, end: _targetBearing).animate(
          CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
        );
    _rotationController.forward(from: 0);
    setState(() => _vehicleBearing = _targetBearing);
  }

  // ✅ Load and Resize to Medium Size
  Future<Uint8List> _loadCarImage() async {
    final ByteData data = await rootBundle.load('assets/images/truck_icon.png');
    final Uint8List bytes = data.buffer.asUint8List();

    // ✅ Resize to medium size (100x100)
    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 200, // ✅ Medium size
      targetHeight: 300, // ✅ Medium size
    );

    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image resizedImage = frameInfo.image;

    final ByteData? resizedData = await resizedImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return resizedData!.buffer.asUint8List();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
      _startTracking();
    } else {
      Get.snackbar(
        'Permission Required',
        'Please enable location permission',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double initialBearing = position.heading >= 0 ? position.heading : 0;
      setState(() {
        _vehicleLat = position.latitude;
        _vehicleLng = position.longitude;
        _vehicleBearing = initialBearing;
        _targetBearing = initialBearing;
        _previousLat = position.latitude;
        _previousLng = position.longitude;
      });
      await Future.delayed(Duration(milliseconds: 500));
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(_vehicleLat, _vehicleLng), 17.0),
        duration: Duration(milliseconds: 1000),
      );
      _speak("Navigation started");
    } catch (e) {
      print('❌ Location error: $e');
    }
  }

  void _startTracking() {
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2,
      ),
    ).listen((position) {
      double newBearing = _vehicleBearing;
      if (position.heading >= 0) {
        newBearing = position.heading;
      } else if (_previousLat != null && _previousLng != null) {
        double distance = Geolocator.distanceBetween(
          _previousLat!,
          _previousLng!,
          position.latitude,
          position.longitude,
        );
        if (distance > 3) {
          newBearing = _calculateBearing(
            _previousLat!,
            _previousLng!,
            position.latitude,
            position.longitude,
          );
        }
      }
      _updateBearing(newBearing);
      setState(() {
        _vehicleLat = position.latitude;
        _vehicleLng = position.longitude;
        _previousLat = position.latitude;
        _previousLng = position.longitude;
      });
      _updateVehicleMarker();
      for (var waypoint in _routeWaypoints) {
        double distance = Geolocator.distanceBetween(
          _vehicleLat,
          _vehicleLng,
          waypoint['lat'],
          waypoint['lng'],
        );
        if (distance < 50) {
          _speak(waypoint['instruction']);
          break;
        }
      }
      if (_isTracking && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(LatLng(_vehicleLat, _vehicleLng)),
          duration: Duration(milliseconds: 500),
        );
      }
    });
  }

  void _updateVehicleMarker() {
    if (_vehicleSymbol != null && _mapController != null) {
      _mapController!.updateSymbol(
        _vehicleSymbol!,
        SymbolOptions(
          geometry: LatLng(_vehicleLat, _vehicleLng),
          iconRotate: _vehicleBearing,
        ),
      );
    }
  }

  void _recenter() {
    setState(() => _isTracking = true);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(_vehicleLat, _vehicleLng), 17.0),
      duration: Duration(milliseconds: 1000),
    );
    Get.snackbar(
      'Tracking ON',
      'Map centered to your location',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MaplibreMap(
            styleString: 'https://tiles.openfreemap.org/styles/liberty',
            initialCameraPosition: CameraPosition(
              target: LatLng(_vehicleLat, _vehicleLng),
              zoom: 17.0,
            ),
            onMapCreated: (controller) async {
              _mapController = controller;
            },
            onStyleLoadedCallback: () async {
              List<LatLng> routePoints = _routeWaypoints
                  .map((wp) => LatLng(wp['lat'], wp['lng']))
                  .toList();
              _routeLine = await _mapController?.addLine(
                LineOptions(
                  geometry: routePoints,
                  lineColor: '#FF6B35',
                  lineWidth: 10.0,
                  lineOpacity: 0.95,
                ),
              );

              final carImage = await _loadCarImage();
              await _mapController?.addImage('car-icon', carImage);

              _vehicleSymbol = await _mapController?.addSymbol(
                SymbolOptions(
                  geometry: LatLng(_vehicleLat, _vehicleLng),
                  iconImage: 'car-icon',
                  iconSize: 0.6, // ✅ Medium size on map
                  iconRotate: _vehicleBearing,
                  iconAnchor: 'center',
                ),
              );

              for (var poi in _pointsOfInterest) {
                final symbol = await _mapController?.addSymbol(
                  SymbolOptions(
                    geometry: LatLng(poi['lat'], poi['lng']),
                    iconImage: 'marker-15',
                    iconSize: 1.8,
                    iconColor: _colorToHex(poi['color']),
                    textField: poi['name'],
                    textSize: 12.0,
                    textOffset: Offset(0, -2),
                    textColor: '#000000',
                    textHaloColor: '#FFFFFF',
                    textHaloWidth: 2.0,
                  ),
                );
                if (symbol != null) _poiSymbols.add(symbol);
              }
            },
            myLocationEnabled: false,
            myLocationTrackingMode: MyLocationTrackingMode.none,
            compassEnabled: false,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
          ),

          if (_isTracking)
            Positioned(
              top: 50.h,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.gps_fixed, color: Colors.white, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Tracking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            bottom: 28.h,
            left: 12.w,
            right: 12.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _btn('Back', () => Get.back()),
                _btn('Download', () {
                  Get.snackbar(
                    'Download',
                    'Route downloaded',
                    backgroundColor: Color(0xFF4A4A4A),
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                  );
                }),
                _btn('Recenter', _recenter),
                _btn('Cancel', () {
                  _flutterTts.stop();
                  Get.back();
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }

  Widget _btn(String text, VoidCallback onTap) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Color(0xFFFF6B35),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _flutterTts.stop();
    super.dispose();
  }
}
