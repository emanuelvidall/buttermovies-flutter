import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: SvgPicture.asset(
            'assets/images/popcorn.svg',
            width: 310,
            height: 310,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.7,
                child: Text(
                  'Welcome to ButterMovies',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                  width: screenWidth * 0.65,
                  child: Text(
                    'Stay updated with new releases, watch trailers, and dive into detailed information about your favorite films.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Color.fromRGBO(214, 70, 70, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      fixedSize: Size(screenWidth * 0.8, 65),
                      padding: EdgeInsets.all(12),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Login')),
              SizedBox(
                height: 20,
              ),
              FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Color.fromRGBO(214, 70, 70, 0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      fixedSize: Size(screenWidth * 0.8, 65),
                      padding: EdgeInsets.all(12),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    debugPrint('test');
                  },
                  child: Text('Register'))
            ],
          ),
        )
      ]),
    );
  }
}
