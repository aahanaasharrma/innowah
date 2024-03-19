import 'package:flutter/material.dart';
import 'package:innowah/signup.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: SliderWithDots(),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Color(0xFFB0C7A6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0), // Increased space above "Go Green" text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'GreenGo',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF243D3A),
                            fontFamily: 'Sora',
                          ),
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                          width: 50,
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Increased space between "Go Green" and "Smart Living" tex
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '    Smart Living,',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'Sora',
                          ),
                        ),
                        SizedBox(height: 5), // Increased space between "Smart Living" and "Sustainable Choices" text
                        Text(
                          'Sustainable Choices',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'Sora',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70), // Increased space between "Sustainable Choices" and "Eco-Friendly Living" text
                    Text(
                      'Eco-Friendly Living at Your Fingertips',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 16,
                        color: Color(0xFF514646),
                      ),
                    ),
                    SizedBox(height: 15), // Increased space between "Eco-Friendly Living" text and the "Get Started" button
                    ElevatedButton(
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                        // Action when Get Started button is pressed
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3A4F3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SliderWithDots extends StatefulWidget {
  @override
  _SliderWithDotsState createState() => _SliderWithDotsState();
}



class Indicator extends StatelessWidget {
  final int index;
  final int currentIndex;

  const Indicator({
    Key? key,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == currentIndex ?  Color(0xFF2F4B4E) : Colors.grey,
        ),
      ),
    );
  }
}

class _SliderWithDotsState extends State<SliderWithDots> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              buildSlide1(),
              buildSlide2(),
              buildSlide3(),
            ],
          ),
        ),
        Expanded(
          flex: 0,
          child: Align(
            alignment: Alignment.bottomCenter, // Align the dots to the bottom
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                    (index) => Indicator(
                  index: index,
                  currentIndex: _currentPage,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


Widget buildSlide1() {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 350,
          height: 350,
          child: Image.asset(
            'assets/images/logo1.png',
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'Green Commute',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 20,
            color: Color(0xFF2F4B4E),
          ),
        ),
        SizedBox(height: 5), // Adjust the spacing between the text and the next widget
        Text(
          'Your Eco-Conscious Choice for a Better  \n'
              '                            Tomorrow',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 16,
            color: Color(0xFF514646),
          ),
        ),
      ],
    ),
  );
}

Widget buildSlide2() {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 350,
          height: 350,
          child: Image.asset(
            'assets/images/logo2.png',
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'EcoPerks',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 20,
            color: Color(0xFF514646),
          ),
        ),
        SizedBox(height: 5), // Adjust the spacing between the text and the next widget
        Text(
          'Rewards for eco-friendly choices with local  \n'
              '                            Businesses',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 16,
            color: Color(0xFF514646),
          ),
        ),
      ],
    ),
  );
}
Widget buildSlide3() {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 350,
          height: 350,
          child: Image.asset(
            'assets/images/logo3.png',
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'Natures Headlines',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 20,
            color: Color(0xFF514646),
          ),
        ),
        SizedBox(height: 5), // Adjust the spacing between the text and the next widget
        Text(
          'Latest news stories on Sustainability, Eco-Tech \n'
              '                          and Green Living',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 16,
            color: Color(0xFF514646),
          ),
        ),
      ],
    ),
  );
}