import 'package:flutter/material.dart';


class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          HeaderIcon(),
          this.child
          

        ],),  
    );
  }
}

class HeaderIcon extends StatelessWidget {

  const HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Icon(Icons.person_pin, color: Colors.white, size: 100,),
      ),
    );
  }
}


class _PurpleBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
            Positioned(child: _Bubble(radiusBubble: 150, contrast: 0.09,), top: 90,left: 30,),
            Positioned(child: _Bubble(radiusBubble: 100, contrast: 0.25,), top: -10,left: -30),
            Positioned(child: _Bubble(radiusBubble: 80, contrast: 0.12,), top: -10,right: -20),
            Positioned(child: _Bubble(radiusBubble: 35, contrast: 0.08,), bottom: 150,left: 190),
            Positioned(child: _Bubble(radiusBubble: 65, contrast: 0.35,), bottom: 100,right: 20),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1),
          Color.fromRGBO(80, 60, 158, 1),
          Color.fromRGBO(60, 40, 138, 1),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.bottomCenter
        )
      
    );
  }
}

class _Bubble extends StatelessWidget {

  final double radiusBubble;
  final double contrast;

  const _Bubble({required this.radiusBubble, required this.contrast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.radiusBubble,
      height: this.radiusBubble,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, this.contrast)
      ),
      
    );
  }
}