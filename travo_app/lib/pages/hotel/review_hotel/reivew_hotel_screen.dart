import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/review_hotel_bloc/review_hotel_bloc.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/flight_utils/flight_utils.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/models/review_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/pages/hotel/review_hotel/description_text.dart';

class ReviewHotelScreen extends StatelessWidget {
  final String hotelId;
  const ReviewHotelScreen({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonTopContainer(title: l10n!.reviews, content: ''),
            BlocProvider(
              create: (context) => ReviewHotelBloc(),
              child: ReviewChild(hotelId: hotelId),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewChild extends StatefulWidget {
  final String hotelId;
  const ReviewChild({super.key, required this.hotelId});

  @override
  State<ReviewChild> createState() => _ReviewChildState();
}

class _ReviewChildState extends State<ReviewChild> {
  @override
  void initState() {
    super.initState();
    context
        .read<ReviewHotelBloc>()
        .add(ReviewHotelRequiredByHotelId(widget.hotelId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewHotelBloc, ReviewHotelState>(
      builder: (context, state) {
        if (state is ReviewHotelLoaded) {
          final reviews = state.reviews; // Use final for better readability
          return Column(
            children: [for (var review in reviews) reviewCard(review)],
          );
          // ListView.builder(
          //   itemCount: reviews.length,
          //   itemBuilder: (context, index) {
          //     return reviewCard(reviews[index]);
          //   },
          // );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Simplified reviewCard function (assuming Card is already imported)
  Widget reviewCard(ReviewModel review) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ColorConstant.whiteColor,
                      ),
                      child: Image.asset(ImageConstant.avatarImg),
                    ),
                    Column(
                      children: [
                        CommonText(text: review.emailUser),
                        CommonText(
                            text: FlightUtils.formatDate(
                                review.ratedTime.toString()))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < 5; i++)
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        // Add more stars as needed
                      ],
                    )
                  ],
                ),
                DescriptionTextWidget(
                  text: review.comment,
                ),
                Row(
                  children: [
                    for (String image in review.photos)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => AspectRatio(
                                aspectRatio: 640 / 480,
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      for (int i = 0; i < 25; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          width: 10,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5E5E5),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CommonIcon(icon: Icons.thumb_up),
                    CommonText(text: review.like.toString()),
                    const SizedBox(width: 30),
                    const CommonIcon(icon: Icons.thumb_down),
                    CommonText(text: review.dislike.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
