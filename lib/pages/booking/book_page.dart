// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:transportation/communication/chat_manager.dart';
import 'package:transportation/components/app_dropdown_field.dart';
import 'package:transportation/components/app_elevated_button.dart';
import 'package:transportation/components/show_map_dialog.dart';
import 'package:transportation/components/tool_bar.dart';
import 'package:transportation/config/app_icons.dart';
import 'package:transportation/pages/booking/book_api.dart';
import 'package:transportation/pages/payment/make_payment.dart';
import 'package:transportation/pages/trip/trip.dart';
import 'package:transportation/styles/app_colors.dart';
import 'package:transportation/validation/input_validation.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookingPageState();
}

final TextEditingController userLocation = TextEditingController();
String? selectedDestination;
// TimeOfDay? departureTime;
// TimeOfDay? returnTime;

class _BookingPageState extends State<BookPage> {
  // Future<void> _pickTime(
  //   BuildContext context,
  //   ValueChanged<TimeOfDay> onSelected,
  // ) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: const TimeOfDay(hour: 9, minute: 0),
  //   );

  //   if (pickedTime != null) {
  //     onSelected(pickedTime);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> tripJson =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // get the json of trip
    final Trip trip = Trip.fromJson(tripJson);

    return Scaffold(
      appBar: Toolbar(title: "Book a Trip"),
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
              Card(
                child: ListTile(
                  leading: Image.asset(
                    AppIcons.ic_whatsapp,
                    width: 40,
                    height: 40,
                  ),
                  title: Text("Chat with Manager"),
                  onTap: () {
                    GetNumberManager.chatWhatsAppWithManager(
                      context,
                      'Hello, I would like to book a trip from ${trip.departure_location} to ${trip.destination_location} on ${trip.tripDate}.',
                      trip.TripId,
                    );
                  },
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
              // SizedBox(height: 20),
              // ApptimeField(
              //   label: "Arrival time",
              //   time: departureTime,
              //   onTap:
              //       () => _pickTime(context, (time) {
              //         setState(() => departureTime = time);
              //       }),
              // ),
              // const SizedBox(height: 20),
              // ApptimeField(
              //   label: "Finish time",
              //   time: returnTime,
              //   onTap:
              //       () => _pickTime(context, (time) {
              //         setState(() => returnTime = time);
              //       }),
              // ),
              SizedBox(height: 40),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      onPressed: () async {
                        bool paymentSuccess = await makePayment(
                          trip.TripId,
                          trip.seatPrice.toDouble(),
                        );
                        if (!paymentSuccess) return; // if not sucsses
                        bool fieldsAreValidate =
                            InputValidation.validateBookingFields(
                              context: context,
                              userLocation: userLocation,
                              selectedDestination: selectedDestination,
                            );
                        if (fieldsAreValidate) {
                          BookApi.sendBookingData(
                            context: context,
                            trip_id: trip.TripId,
                            userLocation: userLocation.text,
                            payment: trip.seatPrice,
                            destinationLocation: selectedDestination.toString(),
                          );
                        }
                      },
                      text: "Secure my seat",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
