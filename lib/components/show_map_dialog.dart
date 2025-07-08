import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> showMapDialog(
  BuildContext context,
  TextEditingController controller,
) async {
  LatLng? selectedLocation;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Select your home"),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: StatefulBuilder(
            builder: (context, setState) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(33.355042, 35.290827),
                  zoom: 13,
                ),
                onTap: (LatLng pos) {
                  setState(() {
                    selectedLocation = pos;
                  });
                },
                markers:
                    selectedLocation != null
                        ? {
                          Marker(
                            markerId: MarkerId("selected"),
                            position: selectedLocation!,
                          ),
                        }
                        : {},
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (selectedLocation != null) {
                controller.text =
                    "${selectedLocation!.latitude}, ${selectedLocation!.longitude}";
              }
              Navigator.pop(context);
            },
            child: Text("Select"),
          ),
        ],
      );
    },
  );
}
