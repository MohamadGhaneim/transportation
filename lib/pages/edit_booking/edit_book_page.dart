import 'package:flutter/material.dart';
import 'package:transportation/components/app_dropdown_field.dart';
import 'package:transportation/components/app_elevated_button.dart';
import 'package:transportation/components/show_map_dialog.dart';
import 'package:transportation/pages/edit_booking/edit_book_api.dart';
import 'package:transportation/pages/trip/trip.dart';
import 'package:transportation/styles/app_colors.dart';

class EditBookPage extends StatefulWidget {
  const EditBookPage({super.key});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

final TextEditingController userLocation = TextEditingController();
String? selectedDestination;

class _EditBookPageState extends State<EditBookPage> {
  @override
  Widget build(BuildContext context) {
    final Trip trip = ModalRoute.of(context)!.settings.arguments as Trip;

    return Scaffold(
      appBar: AppBar(title: const Text(" Edit my Book a Trip")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                color: AppColors.lightOrange,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From: ${trip.departure_location}"),
                      Text("To: ${trip.destination_location}"),
                      Text("Trip Date: ${trip.tripDate}"),
                      Text("Departure Time: ${trip.departureTime}"),
                      Text("Return Time: ${trip.returnTime}"),
                      Text(
                        "Seat Price: \$${trip.seatPrice.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              //UserLocationField(controller: userLocation),
              TextFormField(
                controller: userLocation,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Home Location",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () {
                      showMapDialog(context, userLocation);
                    },
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              AppDropdownField(
                label: "Select your destination location",
                items:
                    trip.specificLocations
                        .map((e) => e.toString())
                        .toSet()
                        .toList(),
                value:
                    trip.specificLocations.contains(selectedDestination)
                        ? selectedDestination
                        : null,
                onChanged: (value) {
                  setState(() => selectedDestination = value.toString());
                },
              ),

              SizedBox(height: 40),

              AppElevatedButton(
                onPressed: () async {
                  EditBookApi.updateBookingData(
                    context: context,
                    trip_id: trip.TripId,
                    userLocation: userLocation.text,
                    destinationLocation: selectedDestination.toString(),
                  );
                },
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
