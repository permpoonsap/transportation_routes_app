class TransportationItem {
  int? keyID; 
  String routeName; 
  String transportType; 
  double distance; 
  double cost; 

  TransportationItem({
    this.keyID,
    required this.routeName,
    required this.transportType,
    required this.distance,
    required this.cost,
  });
}
