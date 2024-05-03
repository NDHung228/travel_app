import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/routes/route_name.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  final int index;
  const CommonBottomNavigationBar({Key? key, required this.index})
      : super(key: key);

  @override
  State<CommonBottomNavigationBar> createState() =>
      _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  late ValueNotifier<int> _selectedIndexNotifier;

  @override
  void initState() {
    super.initState();
    _selectedIndexNotifier = ValueNotifier<int>(widget.index);
  }

  @override
  void dispose() {
    _selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      height: MediaQuery.of(context).size.height / 10,
      color: ColorConstant.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconContainer('Home', Icons.home, 0),
          iconContainer('Favorite', Icons.favorite, 1),
          iconContainer('Payment', Icons.business_center, 2),
          iconContainer('User', Icons.person, 3),
        ],
      ),
    );
  }

  Widget iconContainer(String title, IconData icon, int index) {
    var width = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return index == selectedIndex
            ? SizedBox(
                width: width / 3,
                child: ElevatedButton(
                  onPressed: null, // No action needed when already selected
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: ColorConstant.indigoColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              icon,
                              color: ColorConstant.indigoColor,
                              size: 24.0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          CommonText(
                            size: 15,
                            text: title,
                            color: ColorConstant.indigoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : CommonIcon(
                icon: icon,
                color: ColorConstant.lavenderColor,
                size: 24,
                onPressed: () {
                  _selectedIndexNotifier.value = index;

                  if (title == 'User') {
                    context.go(RoutName.userRouteName);
                  } else if (title == 'Home') {
                    context.go(RoutName.homeRouteName);
                  } else if (title == 'Favorite') {
                    context.go(RoutName.favouriteRouteName);
                  } else {
                    context.go(RoutName.listPaymentRouteName);
                  }
                },
              );
      },
    );
  }
}
