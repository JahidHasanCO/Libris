import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/shared/enums/menu.dart';

class PopupAppMenuButton extends PopupMenuButton<int> {
  PopupAppMenuButton({
    required List<Menu> menus,
    required void Function(int index) super.onSelected,
    List<bool>? selectedIndices,
    super.child,
    super.key,
  }) : super(
         elevation: 8,
         color: Colors.white,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         popUpAnimationStyle: const AnimationStyle(
           curve: Curves.easeInOutQuart,
           duration: Duration(milliseconds: 300),
         ),
         itemBuilder: (context) => [
           for (var i = 0; i < menus.length; i++)
             PopupMenuItem<int>(
               value: i,
               child: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   if (selectedIndices != null)
                     // to prevent checkbox tap detection
                     IgnorePointer(
                       child: Checkbox(
                         value: selectedIndices[i],
                         onChanged: (_) {},
                         checkColor: Colors.white,
                         activeColor: primaryColor,
                         side: const BorderSide(
                           color: greyLightColor,
                           width: 1.2,
                         ),
                         shape: const RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(
                             Radius.circular(4),
                           ),
                         ),
                       ),
                     ),
                   Text(
                     menus[i].title,
                     style: const TextStyle(
                       fontSize: 14,
                       color: textColor,
                     ),
                     overflow: TextOverflow.ellipsis,
                   ),
                 ],
               ),
             ),
         ],
       );
}
