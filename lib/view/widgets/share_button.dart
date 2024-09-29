// import 'package:flutter/material.dart';
// // ignore: unused_import
// import 'package:social_share/social_share.dart'; 
// import 'package:http_bloc_task2/data/models/image/image_model.dart';

// class ShareButton extends StatefulWidget {
//   final ImageObject image;
//   const ShareButton({required this.image, super.key});

//   @override
//   State<ShareButton> createState() => _ShareButtonState();
// }

// class _ShareButtonState extends State<ShareButton> {
//   bool isExpanded = false;

//   void toggleExpand() {
//     setState(() {
//       isExpanded = !isExpanded;
//     });

//     if (isExpanded) {
//       Future.delayed(const Duration(seconds: 3), () {
//         setState(() {
//           isExpanded = false;
//         });
//       });
//     }
//   }

//   Future<void> shareImage(String url) async {
//     try {
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error occurred while sharing: $e'),
//         ),
//       );
//     }
//   }

//   Widget shareIcon() {
//     return IconButton(
//       iconSize: 18,
//       icon: const Icon(
//         Icons.share,
//         shadows: [
//           Shadow(
//             color: Colors.black,
//             blurRadius: 2,
//           ),
//         ],
//       ),
//       onPressed: toggleExpand,
//       style: const ButtonStyle(
//         minimumSize: WidgetStatePropertyAll (Size.zero),
//         shape: WidgetStatePropertyAll (CircleBorder()),
//         iconColor: WidgetStatePropertyAll (
//           Color.fromARGB(255, 48, 63, 159),
//         ),
//       ),
//     );
//   }

//   // Widget socialMediaOption(String platform, IconData icon, String url) {
//   //   return IconButton(
//   //     iconSize: 24,
//   //     icon: Icon(icon, color: Colors.blueAccent),
//   //     onPressed: () {
//   //       shareImage(url);
//   //     },
//   //   );
//   // }

//   Widget buildSocialMediaOptions() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         AnimatedSize(
//           duration: const Duration(milliseconds: 300),
//           reverseDuration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//           child: isExpanded ? buildSocialMediaOptions() : shareIcon(),
//         ),
//       ],
//     );
//   }
// }
