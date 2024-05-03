import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/routes/route_name.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  final isLastPageNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    controller.dispose();
    isLastPageNotifier.dispose(); // Dispose the ValueNotifier
    super.dispose();
  }

  void _handleNextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 4),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            isLastPageNotifier.value = index == 2; // Update ValueNotifier
          },
          children: [
            childOfPageView(ImageConstant.onboarding1, 'Book a flight',
                'Found a flight that matches your destination and schedule? Book it instantly.'),
            childOfPageView(ImageConstant.onboarding2, 'Find a hotel room',
                'Select the day, book your room. We give you the best price.'),
            childOfPageView(ImageConstant.onboarding3, 'Enjoy your trip',
                'Easy discovering new places and share these between your friends and travel together.'),
          ],
        ),
      ),
      bottomSheet: ValueListenableBuilder<bool>(
        valueListenable: isLastPageNotifier,
        builder: (context, isLastPage, _) {
          return Container(
            color: ColorConstant.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            height: MediaQuery.of(context).size.height / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5,
                  height: 40,
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Color.fromARGB(255, 224, 222, 222),
                      activeDotColor: Colors.orange,
                    ),
                  ),
                ),
                !isLastPage
                    ? CommonTextButton(
                        text: 'Next',
                        onPressed: () {
                          _handleNextPage();
                        },
                      )
                    : CommonTextButton(
                        text: 'Get Started',
                        buttonWidth: 175,
                        onPressed: () async {
                          context.pushReplacement(RoutName.homeRouteName);

                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          await prefs.setBool('isOnboarding', true);
                        },
                      )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget childOfPageView(String urlImage, String title, String content) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height / 10),
            child: SizedBox(
              width: width,
              height: height / 2.5,
              // Use Expanded to make the image occupy full width
              child: Image.asset(
                urlImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height / 15, left: width / 11, bottom: height / 40),
            child: CommonText(
              text: title,
              fontWeight: FontWeight.bold,
              size: 24,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 11, right: width / 8),
            child: CommonText(
              text: content,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
