import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/place_bloc/place_bloc.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/skeleton.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/place_model.dart';
import 'package:travo_app/services/home_service/home_services.dart';

class HomeBodyComponent extends StatefulWidget {
  const HomeBodyComponent({Key? key}) : super(key: key);

  @override
  State<HomeBodyComponent> createState() => _HomeBodyComponentState();
}

class _HomeBodyComponentState extends State<HomeBodyComponent> {
  final HomeService _homeService = HomeService();

  late ValueNotifier<List<Place>> isFavoriteList;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlaceBloc>(context).add(const GetPlace());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        if (state is PlaceLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Skeleton(
                        height: 480,
                        width: 640,
                      ),
                    ))),
          );
        }
        if (state is PlaceLoaded) {
          List<Place> placeList = state.placeList;
          isFavoriteList =
              ValueNotifier<List<Place>>(_homeService.getFavoritePlaces());

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: placeList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: placeList[index].img,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => AspectRatio(
                          aspectRatio: 640 / 480,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 90,
                      left: 8,
                      child: CommonText(
                        text: placeList[index].name,
                        color: ColorConstant.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Positioned(
                      bottom: 65,
                      left: 8,
                      child: Container(
                        height: height * 0.02,
                        width: width * 0.1,
                        color: ColorConstant.whiteColor.withOpacity(0.5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Color(0xFFFFC107),
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            CommonText(
                              text: placeList[index].rating.toString(),
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          _homeService.toggleFavorite(placeList[index]);
                          // Update the ValueNotifier directly
                          final updatedFavoritePlaces =
                              _homeService.getFavoritePlaces();
                          isFavoriteList.value = updatedFavoritePlaces;
                        },
                        child: ValueListenableBuilder<List<Place>>(
                          valueListenable: isFavoriteList,
                          builder: (context, favoritePlaces, _) {
                            final isFavorite =
                                favoritePlaces.contains(placeList[index]);
                            return Icon(
                              Icons.favorite,
                              color: isFavorite
                                  ? ColorConstant.errorColor
                                  : ColorConstant.whiteColor,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
