// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:transportation/components/tool_bar.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/trip/trip.dart';
import 'package:transportation/pages/user_bookings/user_bookings_api.dart';

class UserBookingsPage extends StatefulWidget {
  final int userId;

  const UserBookingsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserBookingsPage> createState() => _UserBookingsPageState();
}

class _UserBookingsPageState extends State<UserBookingsPage> {
  late Future<List<Trip>> bookingsFuture;

  @override
  void initState() {
    super.initState();
    bookingsFuture = UserBookingsApi.fetchUserBookings(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(title: 'My Bookings'),
      body: FutureBuilder<List<Trip>>(
        future: bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings found'));
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final trip = bookings[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.editBooking,
                      arguments: trip,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${trip.departure_location} → ${trip.destination_location}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Date: ${trip.tripDate}'),
                        Text(
                          'Seat Price: \$${trip.seatPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Status: ${trip.status}',
                          style: TextStyle(
                            color:
                                trip.status.toLowerCase() == 'active'
                                    ? Colors.red
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
