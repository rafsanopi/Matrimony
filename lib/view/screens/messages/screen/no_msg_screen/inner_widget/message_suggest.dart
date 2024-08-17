// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:matrimony/utils/app_images.dart';
// import 'package:matrimony/utils/app_static_strings.dart';
// import 'package:matrimony/view/widget/customText/custom_text.dart';
// import 'package:matrimony/view/widget/request_card/request_card.dart';

// class MessageSuggest extends StatefulWidget {
//   const MessageSuggest({super.key});

//   @override
//   State<MessageSuggest> createState() => _MessageSuggestState();
// }

// class _MessageSuggestState extends State<MessageSuggest> {
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, top: 44),
//         child: Column(
//           children: [
//             //App Bar

//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               //crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: const Icon(Icons.arrow_back_ios_rounded)),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 const CustomText(
//                   text: AppStaticStrings.sendMessage,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 24,
//             ),

//             // Suggestion

//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: List.generate(data.length, (index) {
//                     return RequestCard(
//                         button0Ontap: () {},
//                         isTwoButton: false,
//                         name: data[index]["name"],
//                         title: data[index]["title"],
//                         subTitle: data[index]["subTitle"],
//                         proPic: data[index]["img"]);
//                   }),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
