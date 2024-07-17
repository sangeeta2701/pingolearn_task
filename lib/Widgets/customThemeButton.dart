

import 'package:flutter/material.dart';
import 'package:pingolearn_task/utils/colors.dart';

import '../utils/constant.dart';

Widget customThemeButton(String bttonText, VoidCallback ontap) {
    return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeColor,
                              shape: RoundedRectangleBorder(
                                
                                borderRadius: BorderRadius.circular(8),
                              )
                            ),
                            onPressed: ontap, child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 28),
                              child: Text(bttonText,style: buttonStyle,),
                            ));
  }