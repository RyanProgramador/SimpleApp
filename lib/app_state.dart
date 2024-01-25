import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _local = _latLngFromString(prefs.getString('ff_local')) ?? _local;
    });
    _safeInit(() {
      _cnoas = _latLngFromString(prefs.getString('ff_cnoas')) ?? _cnoas;
    });
    _safeInit(() {
      _HD = prefs.getStringList('ff_HD')?.map(_latLngFromString).withoutNulls ??
          _HD;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  LatLng? _local = LatLng(-29.8813641, -51.16721629999999);
  LatLng? get local => _local;
  set local(LatLng? _value) {
    _local = _value;
    _value != null
        ? prefs.setString('ff_local', _value.serialize())
        : prefs.remove('ff_local');
  }

  LatLng? _cnoas = LatLng(-29.9077898, -51.1847036);
  LatLng? get cnoas => _cnoas;
  set cnoas(LatLng? _value) {
    _cnoas = _value;
    _value != null
        ? prefs.setString('ff_cnoas', _value.serialize())
        : prefs.remove('ff_cnoas');
  }

  List<LatLng> _HD = [LatLng(0, 0)];
  List<LatLng> get HD => _HD;
  set HD(List<LatLng> _value) {
    _HD = _value;
    prefs.setStringList('ff_HD', _value.map((x) => x.serialize()).toList());
  }

  void addToHD(LatLng _value) {
    _HD.add(_value);
    prefs.setStringList('ff_HD', _HD.map((x) => x.serialize()).toList());
  }

  void removeFromHD(LatLng _value) {
    _HD.remove(_value);
    prefs.setStringList('ff_HD', _HD.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromHD(int _index) {
    _HD.removeAt(_index);
    prefs.setStringList('ff_HD', _HD.map((x) => x.serialize()).toList());
  }

  void updateHDAtIndex(
    int _index,
    LatLng Function(LatLng) updateFn,
  ) {
    _HD[_index] = updateFn(_HD[_index]);
    prefs.setStringList('ff_HD', _HD.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInHD(int _index, LatLng _value) {
    _HD.insert(_index, _value);
    prefs.setStringList('ff_HD', _HD.map((x) => x.serialize()).toList());
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
