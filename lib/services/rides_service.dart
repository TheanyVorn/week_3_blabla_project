import '../data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;

  static List<Ride> filterByDeparture(Location departure) {
    return allRides
        .where((ride) => ride.departureLocation == (departure))
        .toList();
  }

  static List<Ride> filterBySeatRequested(int seatRequested) {
    return allRides
        .where((ride) => ride.remainingSeats >= seatRequested)
        .toList();
  }

  // TODO Create a static method to filter : optional departure location, optional requested seat
  
}
