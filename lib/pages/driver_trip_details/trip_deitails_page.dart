// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:transportation/communication/whatsapp_sender.dart';
import 'package:transportation/pages/Gemini/google_maps_link_generator.dart';
import 'package:transportation/pages/driver_trip_details/booked_user_model.dart';
import 'package:transportation/pages/driver_trip_details/trip_deitails_api.dart';
import 'package:transportation/pages/trip/trip.dart';
import 'package:transportation/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDeitailsPage extends StatefulWidget {
  const TripDeitailsPage({super.key});

  @override
  State<TripDeitailsPage> createState() => _TripDeitailsPageState();
}

class _TripDeitailsPageState extends State<TripDeitailsPage> {
  late Trip trip;
  List<BookedUser> bookedUsers = [];
  bool isLoading = true;
  String? mapsLink;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    trip = Trip.fromJson(args);
    _loadBookedUsersAndLink();
  }

  // LatLng _parseCoords(String coords) {
  //   final parts = coords.split(',');
  //   return LatLng(double.parse(parts[0].trim()), double.parse(parts[1].trim()));
  // }

  Future<void> _loadBookedUsersAndLink() async {
    try {
      final users = await TripDetailsAPI.fetchBookedUsers(trip.TripId);
      final waypoints = users.map((u) => u.userLocation).toList();

      final link = await GoogleMapsLinkGenerator.generateRouteLink(
        origin: trip.departure_coords,
        destination: trip.destination_location,
        waypoints: waypoints,
      );

      setState(() {
        bookedUsers = users;
        mapsLink = link;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _openMapLink() async {
    if (mapsLink != null && await canLaunchUrl(Uri.parse(mapsLink!))) {
      await launchUrl(Uri.parse(mapsLink!));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Can't open the map link")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
        backgroundColor: AppColors.lightOrange,
      ),
      body: Column(
        children: [
          if (mapsLink != null)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Open Route in Google Maps'),
                onPressed: _openMapLink,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: bookedUsers.length,
              itemBuilder: (context, index) {
                final user = bookedUsers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: InkWell(
                    onTap: () {
                      WhatsApp.openWhatsApp(user.phoneNumber, '');
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            (user.userPhoto != null &&
                                    user.userPhoto.isNotEmpty)
                                ? NetworkImage(user.userPhoto)
                                : AssetImage('assets/images/user.png')
                                    as ImageProvider,
                      ),
                      title: Text(user.fullName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('📞 ${user.phoneNumber}'),
                          Text('💰 Payment: \$${user.payment}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
