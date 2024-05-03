import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travo_app/common_widgets/common_bottom_navigation_bar.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/place_model.dart';
import 'package:travo_app/services/home_service/home_services.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late HomeService _homeService;

  late List<Place> placeList;
  late ValueNotifier<bool> dataLoadedNotifier;
  late ValueNotifier<List<Place>> isFavoriteList;

  @override
  void initState() {
    super.initState();
    dataLoadedNotifier = ValueNotifier<bool>(false);
    isFavoriteList = ValueNotifier<List<Place>>([]);
  }



  Future<void> loadData() async {
    _homeService = HomeService();
    await _homeService.initializeSharedPreferences();

    placeList = _homeService.getFavoritePlaces();
    isFavoriteList.value = placeList;
    dataLoadedNotifier.value = true;
  }

  Future<void> _refresh() async {
    dataLoadedNotifier.value = false;
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            const CommonTopContainer(title: 'Favorite', content: ''),
            FutureBuilder(
              future: loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {

                  return Text('Error: ${snapshot.error.toString()}');
                } else {
                  return ValueListenableBuilder<bool>(
                      valueListenable: dataLoadedNotifier,
                      builder: (context, dataLoaded, _) {
                        isFavoriteList = ValueNotifier<List<Place>>(
                            _homeService.getFavoritePlaces());
                        return buildGridView();
                      });
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(
        index: 1,
      ),
    );
  }

  Widget buildGridView() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    loadData();


    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.1,
          vertical: 8,
        ),
        child: MasonryGridView.builder(
          itemCount: placeList.length,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: placeList[index].img,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => AspectRatio(
                      aspectRatio: 640 / 480,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 8,
                  child: CommonText(
                    text: placeList[index].name,
                    color: ColorConstant.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Positioned(
                  bottom: 8,
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
      ),
    );
  }
}
