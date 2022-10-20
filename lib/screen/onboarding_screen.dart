import 'package:alive_and_kicking/models/alive_and_kicking_pages.dart';
import 'package:alive_and_kicking/models/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {

  static MaterialPage page() {
    return MaterialPage(
      name: AliveAndKickingPages.onboardingPath,
      key: ValueKey(AliveAndKickingPages.onboardingPath),
      child: const OnboardingScreen(),
    );
  }
  
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Getting Started'),
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
          // https://docs.flutter.dev/cookbook/navigation/returning-data
          onTap: () => Navigator.pop(context, true),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: buildPages()),
            buildIndicator(),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: WormEffect(
        activeDotColor: rwColor,
      ),
    );
  }

  Widget onboardPageView(ImageProvider imageProvider, String text) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image(
              fit: BoxFit.fitWidth,
              image: imageProvider,
            ),
          ),
          const SizedBox(height: 16,),
          Text(
            text,
            style: const TextStyle(fontSize: 20,),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }

  Widget buildPages() {
    return PageView(
      controller: pageController,
      children: <Widget>[
        onboardPageView(
          const AssetImage('assets/fooderlich_assets/recommend.png'),
          'Check out weekly recommended recipes and what your friends are cooking!',
        ),
        onboardPageView(
          const AssetImage('assets/fooderlich_assets/sheet.png'),
          'Cook with step by step instructions!',
        ),
        onboardPageView(
          const AssetImage('assets/fooderlich_assets/list.png'),
          'Keep track of what you need to buy!',
        ),
      ],
      onPageChanged: (page) {
        setState(() {
          currentPage = page;
        });
      },
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MaterialButton(
          child: currentPage > 1 ? const Text('Finish') : const Text('Skip'),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .completeOnboarding();
          },
        ),
      ],
    );
  }
}
