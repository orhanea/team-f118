import 'package:bookchain/meta_app/helpers/constants/assets.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/meta_app/helpers/constants/paddings.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';
import 'package:bookchain/meta_app/helpers/constants/textStyles.dart';
import 'package:bookchain/meta_app/helpers/routers/constant_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'welcomeScreens.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double opacity = 1.0;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: getPages(),
      showNextButton: true,
      globalBackgroundColor: ColorSpecs.colorInstance.white,
      showSkipButton: true,
      showDoneButton: true,
      skip: const _Skip(),
      next: const _Next(),
      done: const _Done(),
      onDone: () {
        ConstRoutes.homeScreenRoute;
      },
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(8),
      dotsDecorator: _decorateDots(),
    ));
  }

  DotsDecorator _decorateDots() {
    return DotsDecorator(
      activeColor: ColorSpecs.colorInstance.yankeeBlue,
      size: const Size.square(10.0),
      activeSize: const Size(20.0, 10.0),
      activeShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      spacing: const EdgeInsets.symmetric(horizontal: 3.0),
    );
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        titleWidget: const Text(""),
        bodyWidget: Padding(
          padding: Paddings.paddingInstance.general,
          child: _WidgetForOnBoardingBody(
            title: Strings.stringInstance.onBoardingMainTitle1,
            subTitle: Strings.stringInstance.onBoardingSubTitle1,
            path: AssetPath.assetInstance.onBoardingImage1,
            opacity: opacity,
            visible: visible,
          ),
        ),
        decoration: _widgetForDecoration(),
      ),
      PageViewModel(
          titleWidget: const Text(""),
          bodyWidget: Padding(
            padding: Paddings.paddingInstance.general,
            child: _WidgetForOnBoardingBody(
              title: Strings.stringInstance.onBoardingMainTitle2,
              subTitle: Strings.stringInstance.onBoardingSubTitle2,
              path: AssetPath.assetInstance.onBoardingImage2,
              opacity: opacity,
              visible: visible,
            ),
          ),
          decoration: _widgetForDecoration()),
      PageViewModel(
          titleWidget: const Text(""),
          bodyWidget: Padding(
            padding: Paddings.paddingInstance.general,
            child: _WidgetForOnBoardingBody(
              title: Strings.stringInstance.onBoardingMainTitle3,
              subTitle: Strings.stringInstance.onBoardingSubTitle3,
              path: AssetPath.assetInstance.onBoardingImage3,
              opacity: opacity,
              visible: visible,
            ),
          ),
          decoration: _widgetForDecoration()),
    ];
  }

  PageDecoration _widgetForDecoration() {
    return PageDecoration(
      imageAlignment: Alignment.bottomCenter,
      bodyTextStyle: TextStyles.styleInstance.smallRegular
          .copyWith(color: ColorSpecs.colorInstance.black),
      bodyAlignment: Alignment.center,
      bodyFlex: 2,
    );
  }
}

class _Next extends StatelessWidget {
  const _Next({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: ColorSpecs.colorInstance.yankeeBlue),
      child: Icon(
        Icons.arrow_forward,
        color: ColorSpecs.colorInstance.white,
      ),
    );
  }
}

class _Done extends StatelessWidget {
  const _Done({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: ColorSpecs.colorInstance.yankeeBlue),
      child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
          child: Icon(
            Icons.done,
            color: ColorSpecs.colorInstance.white,
          )),
    );
  }
}

class _Skip extends StatelessWidget {
  const _Skip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      },
      child: Text(
        Strings.stringInstance.passToLogin,
        style: TextStyles.styleInstance.largeMedium
            .copyWith(color: ColorSpecs.colorInstance.yankeeBlue),
      ),
    );
  }
}

class _WidgetForOnBoardingBody extends StatelessWidget {
  final String path;
  final String title;
  final String subTitle;
  const _WidgetForOnBoardingBody(
      {Key? key,
      required this.opacity,
      required this.visible,
      required this.title,
      required this.subTitle,
      required this.path})
      : super(key: key);

  final double opacity;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 245,
        child: IgnorePointer(
          ignoring: visible,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(seconds: 200),
            child: _CardImages(
              images: AssetImage(path),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Center(
          child: Text(
        title,
        style: TextStyles.styleInstance.title1
            .copyWith(color: ColorSpecs.colorInstance.yankeeBlue),
      )),
      const SizedBox(
        height: 30,
      ),
      Text(
        subTitle,
        style: TextStyles.styleInstance.smallMedium
            .copyWith(color: ColorSpecs.colorInstance.neutral),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}

class _CardImages extends StatelessWidget {
  final ImageProvider images;
  const _CardImages({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          image: DecorationImage(image: images, fit: BoxFit.contain)),
    );
  }
}
