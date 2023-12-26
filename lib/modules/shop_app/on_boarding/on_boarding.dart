import 'package:flutter/material.dart';
import 'package:flutter_application/modules/shop_app/login/login.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/network/local/cach_helper.dart';
import 'package:flutter_application/shared/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BordingModel {
  final String image;
  final String body;
  final String title;

  BordingModel({required this.image, required this.body, required this.title});
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  List<BordingModel> boarding = [
    BordingModel(
      title: 'Screen Title 1',
      body: 'Screen  body 1 ',
      image: 'assets/images/onboard_1.jpg',
    ),
    BordingModel(
      title: 'Screen Title 2',
      body: 'Screen  body 2 ',
      image: 'assets/images/onboard_1.jpg',
    ),
    BordingModel(
      title: 'Screen Title 3',
      body: 'Screen  body 3 ',
      image: 'assets/images/onboard_1.jpg',
    ),
  ];

  var boardingController = PageController();
  bool islast = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: Text('SKIP'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    if (value == boarding.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: boardingController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defoultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 0.5,
                      expansionFactor: 4,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: defoultColor,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (islast == true) {
                        submit();
                      } else {
                        boardingController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios_sharp),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BordingModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );

  void submit() {
    CachHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigatorTOAndEnd(context, shopLogin());
      }
    });
  }
}
