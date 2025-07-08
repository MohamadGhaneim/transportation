// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:transportation/components/tool_bar.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/driver_trips/driver_trips_api.dart';
import 'package:transportation/pages/trip/trip.dart';

class DriverTripsPage extends StatefulWidget {
  final int driverId;

  const DriverTripsPage({Key? key, required this.driverId}) : super(key: key);

  @override
  State<DriverTripsPage> createState() => _DriverTripsPageState();
}

class _DriverTripsPageState extends State<DriverTripsPage> {
  late Future<List<Trip>>? _tripsFuture;

  @override
  void initState() {
    super.initState();
    _tripsFuture = TripService.fetchDriverTrips(widget.driverId);
  }

  Future<void> _refreshTrips() async {
    final refreshed = TripService.fetchDriverTrips(widget.driverId);
    setState(() {
      _tripsFuture = refreshed;
    });
    await refreshed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(title: 'Task Schedule'),
      body: RefreshIndicator(
        onRefresh: _refreshTrips,
        child: FutureBuilder<List<Trip>>(
          future: _tripsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final trips = snapshot.data ?? [];

            if (trips.isEmpty) {
              return const Center(child: Text('No trips found.'));
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shadowColor: Colors.grey.withOpacity(0.3),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.tripdetails,
                        arguments: trip.toJson(),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            trip.status == 'Active'
                                ? Colors.green.withOpacity(0.05)
                                : Colors.orange.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor:
                                trip.status == 'Active'
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (child, anim) => ScaleTransition(
                                    scale: anim,
                                    child: child,
                                  ),
                              child: Icon(
                                trip.status == 'Active'
                                    ? Icons.directions_bus
                                    : Icons.access_time,
                                key: ValueKey(trip.status),
                                color:
                                    trip.status == 'Active'
                                        ? Colors.green
                                        : Colors.orange,
                                size: 26,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color:
                                        trip.status == 'Active'
                                            ? Colors.greenAccent
                                            : Colors.orangeAccent,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${trip.departure_location} → ${trip.destination_location}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '📅 ${trip.tripDate}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                Text(
                                  '🕒 ${trip.departureTime} → ${trip.returnTime}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                // Text(
                                //   '💵 \$${trip.seatPrice.toStringAsFixed(2)}',
                                //   style: TextStyle(
                                //     color: Colors.teal[700],
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                              ],
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
      ),
    );
  }
}
