// ignore_for_file: constant_identifier_names
import 'package:transportation/pages/booking/book_page.dart';
import 'package:transportation/pages/driver_trip_details/trip_deitails_page.dart';
import 'package:transportation/pages/driver_trips/driver_trips_page.dart';
import 'package:transportation/pages/edit_booking/edit_book_page.dart';
import 'package:transportation/pages/forgot_password/forgot_password.dart';
import 'package:transportation/pages/login/login_page.dart';
import 'package:transportation/pages/main/main_page.dart';
import 'package:transportation/pages/profile/profile_page.dart';
import 'package:transportation/pages/signup/signup_page.dart';
import 'package:transportation/pages/user_bookings/user_bookings_page.dart';

class AppRoutes {
  static const login = '/';
  static const signup = '/signup';
  static const forgotpassword = '/forgot';
  static const mainpage = '/main';
  static const bookpage = '/booking';
  static const userbookspage = '/userbookings';
  static const editProfile = '/editprofile';
  static const driverTrips = '/drivertrips';
  static const editBooking = '/editbooking';
  static const tripdetails = '/tripdetails';

  static final pages = {
    AppRoutes.login: (context) => LoginPage(),
    AppRoutes.signup: (context) => SignupPage(),
    AppRoutes.forgotpassword: (context) => ForgotPassword(),
    AppRoutes.mainpage: (context) => MainPage(),
    AppRoutes.bookpage: (context) => BookPage(),
    AppRoutes.userbookspage: (context) => UserBookingsPage(userId: 0),
    AppRoutes.editProfile: (context) => EditProfilePage(),
    AppRoutes.driverTrips: (context) => DriverTripsPage(driverId: 0),
    AppRoutes.editBooking: (context) => EditBookPage(),
    AppRoutes.tripdetails: (context) => TripDeitailsPage(),
  };
}
