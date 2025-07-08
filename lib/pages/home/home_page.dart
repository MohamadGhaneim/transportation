// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/components/tool_bar.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/trip/load_trip.dart';
import 'package:transportation/pages/trip/trip.dart';
import 'package:transportation/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fullName = "Guest";
  late Future<List<Trip>> tripsFuture;

  @override
  void initState() {
    super.initState();
    loadFullName();
    tripsFuture = LoadTrip.fetchTrips();
  }

  Future<void> loadFullName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('fullName');
    setState(() {
      fullName = name ?? "Guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        //automaticallyImplyLeading: false,
        title: "Hi , ${fullName}",
      ),
      body: FutureBuilder<List<Trip>>(
        future: tripsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            return Center(child: Text("Error: $errorMessage"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No trips yet",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            );
          }

          final trips = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              await loadFullName();
              setState(() {
                tripsFuture = LoadTrip.fetchTrips();
              });
            },
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.bookpage, arguments: trip.toJson());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.lightOrange.withOpacity(0.8),
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/temp/bus.jpg",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 16),

                            // 📝 Trip Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Launch: ${trip.tripDate}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text("📍 From: ${trip.departure_location}"),
                                  Text("🎯 To: ${trip.destination_location}"),
                                  const SizedBox(height: 6),
                                  Text(
                                    "💵 Price: \$${trip.seatPrice.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.teal[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          trip.status == 'Active'
                                              ? Colors.green.withOpacity(0.1)
                                              : Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      trip.status,
                                      style: TextStyle(
                                        color:
                                            trip.status == 'Active'
                                                ? Colors.green
                                                : Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
