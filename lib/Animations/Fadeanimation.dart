// ignore_for_file: file_names
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, annotate_overrides

// import 'package:flutter/material.dart';

// class FadeInUp extends StatefulWidget {
//   FadeInUpState createState() => FadeInUpState();
// }

// class FadeInUpState extends State<FadeInUp> with TickerProviderStateMixin {

//   late AnimationController controller;
//   late Animation<double> animation;

//   initState() {
//     super.initState();
//     controller = AnimationController(
//         duration: const Duration(milliseconds: 1000), vsync: this);
//     animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

//     /*animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         controller.reverse();
//       } else if (status == AnimationStatus.dismissed) {
//         controller.forward();
//       }
//     });*/

//     controller.forward();
//   }

//   Widget build(BuildContext context) {

//     return Container(
//         color: Colors.white,
//         child: FadeTransition(
//             opacity: animation,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children:[
//                   Icon(Icons.check, size: 100.0,color: Colors.green,),
//                 ]
//             )
//         )
//     );
//   }
// }