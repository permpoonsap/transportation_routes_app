import 'package:flutter/foundation.dart';
import 'package:transportation_routes_app/model/transportation_item.dart';

class TransportationProvider with ChangeNotifier {
  List<TransportationItem> _transportations = [];

  List<TransportationItem> getTransportation() {
    return List.unmodifiable(_transportations);
  }

  void initData() {
    _transportations = [
    ];
    notifyListeners();
  }

  void addTransportation(TransportationItem transportation) {
    _transportations.add(transportation);
    notifyListeners();
  }

  void deleteTransportation(TransportationItem transportation) {
    _transportations.remove(transportation);
    notifyListeners();
  }

  void updateTransportation(TransportationItem transportation, int index) {
    if (index >= 0 && index < _transportations.length) {
      _transportations[index] = transportation;
      notifyListeners();
    }
  }
}
