// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../const/app_colors.dart';
// import '../controller/base_controller.dart';

// class DisEmojiController extends BaseController {

//   @override
//   void onInit() {
//     super.onInit();
//   }
// }

// class DisEmojiPicker extends StatelessWidget {
//   final Function(String) onEmojiSelected;
//   final double? height;
//   final double? emojiSize;
//   final bool showBackspace;
//   final Color? backgroundColor;

//   DisEmojiPicker({
//     super.key,
//     required this.onEmojiSelected,
//     this.height,
//     this.emojiSize,
//     this.showBackspace = false,
//     this.backgroundColor,
//   }) {
//     Get.put(DisEmojiController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<DisEmojiController>();
    
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return SizedBox(
//           height: height ?? 256.w,
//           child: const Center(child: CircularProgressIndicator()),
//         );
//       }

//       return SizedBox(
//         height: height ?? 256.w,
//         child: EmojiPicker(
//           onEmojiSelected: (category, emoji) {
//             onEmojiSelected(emoji.emoji);
//           },
//           config: Config(
//             height: height ?? 256.w,
//             emojiViewConfig: EmojiViewConfig(
//               columns: 7,
//               emojiSizeMax: emojiSize ?? 24.w,
//               backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
//             ),
//             categoryViewConfig: const CategoryViewConfig(
//               indicatorColor: AppColors.primary,
//               iconColorSelected: AppColors.primary,
//               iconColor: Colors.grey,
//               tabIndicatorAnimDuration: kTabScrollDuration,
//               categoryIcons: CategoryIcons(
//                 recentIcon: CupertinoIcons.clock,
//                 smileyIcon: CupertinoIcons.smiley,
//                 animalIcon: CupertinoIcons.paw,
//                 foodIcon: CupertinoIcons.cart,
//                 activityIcon: CupertinoIcons.person_2,
//                 travelIcon: CupertinoIcons.airplane,
//                 objectIcon: CupertinoIcons.lightbulb,
//                 symbolIcon: CupertinoIcons.number,
//                 flagIcon: CupertinoIcons.flag,
//               ),
//             ),
//             bottomActionBarConfig: BottomActionBarConfig(
//               enabled: showBackspace,
//               showBackspaceButton: showBackspace,
//               backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// class DisEmojiButton extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback? onPressed;
//   final bool showEmoji;

//   const DisEmojiButton({
//     super.key,
//     required this.controller,
//     required this.showEmoji,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: onPressed,
//       icon: Icon(
//         showEmoji ? Icons.keyboard_alt_outlined : Icons.emoji_emotions_outlined,
//         size: 24.w,
//       ),
//     );
//   }
// }