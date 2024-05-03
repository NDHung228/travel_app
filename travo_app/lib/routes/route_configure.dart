import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:travo_app/models/hotel.model.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/pages/auth/forgot_password_screen.dart';
import 'package:travo_app/pages/auth/sign_in_screen.dart';
import 'package:travo_app/pages/auth/sign_up_screen.dart';
import 'package:travo_app/pages/booking_flight/payment_booking_flight/book_review_flight.dart';
import 'package:travo_app/pages/booking_flight/payment_booking_flight/confirm_flight.dart';
import 'package:travo_app/pages/booking_flight/payment_booking_flight/payment_flight_screen.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/filter_facilities.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/search_booking_flight_screen.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/search_result_flight.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/sort_flight.dart';
import 'package:travo_app/pages/booking_flight/select_seat/select_seat_screen.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/add_card.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/add_contact.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/add_promo_code.dart';
import 'package:travo_app/pages/booking_hotel/confirm_booking_room.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_screen.dart';
import 'package:travo_app/pages/booking_hotel/payment_screen.dart';
import 'package:travo_app/pages/favourite/favourite_screen.dart';
import 'package:travo_app/pages/home/home_screen.dart';
import 'package:travo_app/pages/hotel/hotel_components/hotel_filter_sort.dart';
import 'package:travo_app/pages/hotel/hotel_detail/hotel_detail_screen.dart';
import 'package:travo_app/pages/hotel/hotel_screen.dart';
import 'package:travo_app/pages/hotel/review_hotel/reivew_hotel_screen.dart';
import 'package:travo_app/pages/list_payment/payment_screen.dart';
import 'package:travo_app/pages/onboarding/onboarding_screen.dart';
import 'package:travo_app/pages/room/room_screen.dart';
import 'package:travo_app/pages/splash/splash_screen.dart';
import 'package:travo_app/pages/user/user_screen.dart';
import 'package:travo_app/routes/route_name.dart';

class AppRoutes {
  static Page<dynamic> Function(BuildContext, GoRouterState) buildMaterialPage(
      Widget child) {
    return (context, state) => MaterialPage(child: child);
  }

  static GoRoute buildRouteNoExtra(String path, Widget child) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return MaterialPage(child: child);
      },
    );
  }

  static GoRoute buildRouteWithExtra<T>(
      String path, Widget Function(T) pageBuilder) {
    // Define a factory function to create page builder functions
    Page<dynamic> Function(BuildContext, GoRouterState) pageBuilderFactory(
        T data) {
      return (context, state) {
        return MaterialPage(
          child: pageBuilder(data),
        );
      };
    }

    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        final data = state.extra as T;
        return pageBuilderFactory(data)(context, state);
      },
    );
  }

  static final GoRouter routes = GoRouter(routes: <GoRoute>[
    buildRouteNoExtra(RoutName.homeRouteName, const HomeScreen()),
    buildRouteNoExtra(RoutName.onBoardingRouteName, const OnBoardingScreen()),
    buildRouteNoExtra(RoutName.splashRouteName, const SplashScreen()),

    // auth
    buildRouteNoExtra(RoutName.signInRouteName, const SignInScreen()),
    buildRouteNoExtra(RoutName.signUpRouteName, const SignUpScreen()),
    buildRouteNoExtra(
        RoutName.forgotPasswordRouteName, const ForgotPasswordScreen()),

    buildRouteNoExtra(RoutName.hotelRouteName, const HotelScreen()),
    buildRouteNoExtra(RoutName.favouriteRouteName, const FavouriteScreen()),
    buildRouteNoExtra(RoutName.userRouteName, const UserScreen()),

    buildRouteWithExtra<Hotel>(
      RoutName.detailHotelRouteName,
      (hotel) => HotelDetailScreen(hotel: hotel),
    ),

    buildRouteWithExtra<String>(
      RoutName.reviewHotel,
      (hotelId) => ReviewHotelScreen(hotelId: hotelId),
    ),

    buildRouteWithExtra<String>(
      RoutName.roomRouteName,
      (hotelId) => RoomScreen(hotelId: hotelId),
    ),

    buildRouteWithExtra<Room>(
      RoutName.bookingHotelRouteName,
      (room) => BookingHotelScreen(room: room),
    ),

    buildRouteNoExtra(RoutName.addContactRouteName, const AddContact()),
    buildRouteNoExtra(RoutName.addPromoCodeRouteName, const AddPromoCode()),

    buildRouteWithExtra<BookingHotel>(
      RoutName.paymentRouteName,
      (bookingHotel) => PaymentScreen(bookingHotel: bookingHotel),
    ),
    buildRouteNoExtra(RoutName.addCardRouteName, const AddCard()),
    buildRouteWithExtra<BookingHotel>(
      RoutName.confirmBookingRoomRouteName,
      (bookingHotel) => ConFirmBookingRoom(bookingHotel: bookingHotel),
    ),

    buildRouteNoExtra(RoutName.listPaymentRouteName, const ListPaymentScreen()),
    buildRouteNoExtra(RoutName.searchBookingFlightRouteName,
        const SearchBookingFlightScreen()),

    buildRouteWithExtra<BookingFlight>(
      RoutName.searchResultFlightRouteName,
      (bookingFlight) => SearchResultFlight(
        bookingFlight: bookingFlight,
      ),
    ),

    buildRouteNoExtra(
      RoutName.filterFacilitiesFlightRouteName,
      const FilterFacilities(),
    ),

    buildRouteWithExtra<ValueNotifier<String>>(
      RoutName.sortFlightRouteName,
      (sortNotifier) => SortFlight(sortNotifier: sortNotifier),
    ),

    buildRouteWithExtra<Map<String, dynamic>>(
      RoutName.selectSeatRouteName,
      (data) => SelectSeatScreen(
        flight: data['flight'] as Flight,
        bookingFlight: data['bookingFlight'] as BookingFlight,
      ),
    ),

    buildRouteWithExtra<Map<String, dynamic>>(
      RoutName.selectSeatRouteName,
      (data) => SelectSeatScreen(
        flight: data['flight'] as Flight,
        bookingFlight: data['bookingFlight'] as BookingFlight,
      ),
    ),

    buildRouteWithExtra<Map<String, dynamic>>(
      RoutName.bookReviewFlight,
      (data) => BookReviewFlight(
        bookingFlight: data['bookingFlight'] as BookingFlight,
        flight: data['flight'] as Flight,
      ),
    ),

    buildRouteWithExtra<BookingFlight>(
      RoutName.paymentFlight,
      (bookingFlight) => PaymentFlightScreen(bookingFlight: bookingFlight),
    ),

    buildRouteWithExtra<BookingFlight>(
      RoutName.confirmFlight,
      (bookingFlight) => ConfirmFlight(bookingFlight: bookingFlight),
    ),

    buildRouteNoExtra(
      RoutName.filterSort,
      const HotelFilterSort(),
    ),
  ]);
}
