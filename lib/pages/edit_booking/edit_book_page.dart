import 'package:flutter/material.dart';
import 'package:transportation/communication/chat_manager.dart';
import 'package:transportation/components/app_dropdown_field.dart';
import 'package:transportation/components/app_elevated_button.dart';
import 'package:transportation/components/show_map_dialog.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/edit_booking/edit_book_api.dart';
import 'package:transportation/pages/login/login_class.dart';
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
              SizedBox(height: 20),
              AppElevatedButton(
                onPressed: () async {
                  // are you sure you want to cancel the booking?
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          icon: Icon(Icons.warning, color: Colors.amber),
                          title: Text("Confirm Cancellation"),
                          content: Text(
                            "Are you sure you want to cancel your booking for the trip from ${trip.departure_location} to ${trip.destination_location} on ${trip.tripDate}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("Yes"),
                            ),
                          ],
                        ),
                  );
                  if (confirm == true) {
                    EditBookApi.deleteBooking(
                      context: context,
                      trip_id: trip.TripId,
                    );
                    // get fullName of the user from sheard preferences
                    final fullName = User.currentUser!.fullName;
                    GetNumberManager.chatWhatsAppWithManager(
                      context,
                      "Hello, I am ${fullName}. I would like to cancel my booking for the trip from ${trip.departure_location} to ${trip.destination_location} on ${trip.tripDate}, and request a refund of USD ${trip.seatPrice}.",
                      trip.TripId,
                    );
                    Navigator.pushNamed(context, AppRoutes.mainpage);
                  }
                },
                text: "Canceled",
                bgColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
