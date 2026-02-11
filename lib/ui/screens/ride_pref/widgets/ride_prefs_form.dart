import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/ui/widgets/actions/bla_button.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/services/location_service.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? fromLocation;
  late DateTime travelDate;
  Location? toLocation;
  late int seatCount;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    final init = widget.initRidePref;
    fromLocation = init?.departure;
    toLocation = init?.arrival;
    travelDate = init?.departureDate ?? DateTime.now();
    seatCount = init?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  List<DropdownMenuItem<Location>> get _locationOptions => LocationsService
      .availableLocations
      .map(
        (location) => DropdownMenuItem<Location>(
          value: location,
          child: Text(location.name),
        ),
      )
      .toList();

  void _swapStops() => setState(() {
    final temp = fromLocation;
    fromLocation = toLocation;
    toLocation = temp;
  });

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: travelDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => travelDate = picked);
  }

  void _onSearch() {
    // Intentionally no navigation
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    final dateLabel = MaterialLocalizations.of(
      context,
    ).formatMediumDate(travelDate);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<Location>(
          initialValue: fromLocation,
          decoration: InputDecoration(
            labelText: 'Departure',
            prefixIcon: const Icon(Icons.radio_button_unchecked),
            suffixIcon: IconButton(
              onPressed: _swapStops,
              icon: const Icon(Icons.swap_vert),
            ),
          ),
          items: _locationOptions,
          onChanged: (value) => setState(() => fromLocation = value),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<Location>(
          initialValue: toLocation,
          decoration: const InputDecoration(
            labelText: 'Arrival',
            prefixIcon: Icon(Icons.radio_button_unchecked),
          ),
          items: _locationOptions,
          onChanged: (value) => setState(() => toLocation = value),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _selectDate,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Date',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            child: Text(dateLabel),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<int>(
          initialValue: seatCount,
          decoration: const InputDecoration(
            labelText: 'Seats',
            prefixIcon: Icon(Icons.person),
          ),
          items: const [1, 2, 3, 4]
              .map((s) => DropdownMenuItem<int>(value: s, child: Text('$s')))
              .toList(),
          onChanged: (value) => setState(() => seatCount = value ?? 1),
        ),
        const SizedBox(height: 15),
        BlaButton(
          text: 'Search',
          icon: Icons.search,
          enabled: true,
          onPressed: _onSearch,
        ),
      ],
    );
  }
}
