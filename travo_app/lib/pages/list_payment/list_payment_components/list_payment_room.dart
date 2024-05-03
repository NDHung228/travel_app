import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/room_bloc/room_bloc.dart';
import 'package:travo_app/common_widgets/common_contact_detail.dart';
import 'package:travo_app/common_widgets/common_icon_text.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/skeleton.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_date.dart';

class ListPaymentRoom extends StatefulWidget {
  final List<BookingHotel> listBookingRoom;

  const ListPaymentRoom({Key? key, required this.listBookingRoom})
      : super(key: key);

  @override
  State<ListPaymentRoom> createState() => _ListPaymentRoomState();
}

class _ListPaymentRoomState extends State<ListPaymentRoom> {
  late List<Room?> _rooms;

  @override
  void initState() {
    super.initState();
    _fetchRooms();
  }

  void _fetchRooms() {
    _rooms = List<Room?>.filled(widget.listBookingRoom.length, null);
    for (int i = 0; i < widget.listBookingRoom.length; i++) {
      BlocProvider.of<RoomBloc>(context)
          .add(GetRoomRequiredById(roomId: widget.listBookingRoom[i].room!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.listBookingRoom.length,
        itemBuilder: (BuildContext context, int index) {
          return BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) {
              if (state is GetRoomLoadedById) {
                _rooms[index] = state.room;
                return _buildRoomDetails(
                    widget.listBookingRoom[index], state.room);
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Skeleton(
                      height: 300,
                      width: 300,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRoomDetails(BookingHotel bookingHotel, Room? room) {
    if (room == null) {
      return const SizedBox(); // or loading indicator or error message
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return detailBookingRoom(bookingHotel, room, height, width);
  }

  // Rest of your code remains the same
}

Widget detailBookingRoom(
    BookingHotel bookingHotel, Room room, double height, double width) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  10.0), // Set the desired border radius here
              child: CachedNetworkImage(
                imageUrl: room.image,
                fit: BoxFit.fill,
                placeholder: (context, url) => AspectRatio(
                  aspectRatio: (640) / 480,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: room.name,
                  fontWeight: FontWeight.w500,
                  size: 20,
                ),
                SizedBox(
                    width: width * 0.8,
                    child: Expanded(
                      child: CommonIconText(
                          icon: Icons.payment,
                          title: 'Total',
                          content: '\$${bookingHotel.price}'),
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    for (int i = 0; i < width / 14; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        width: width * 0.02,
                        height: height * 0.0025,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5E5E5),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                  ],
                ),
                BookingDate(
                  startDateNotifier: ValueNotifier<DateTime?>(
                    bookingHotel.date_start != null
                        ? DateTime.parse(bookingHotel.date_start!)
                        : null,
                  ),
                  endDateNotifier: ValueNotifier<DateTime?>(
                    bookingHotel.date_end != null
                        ? DateTime.parse(bookingHotel.date_end!)
                        : null,
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < width / 14; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        width: width * 0.02,
                        height: height * 0.0025,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5E5E5),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                  ],
                ),
                Column(
                  children: bookingHotel.guest!
                      .map((contactDetail) =>
                          CommonContactDetail(contactDetail: contactDetail))
                      .toList(),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
