import 'dart:ui';
import 'package:eltawfiq_suppliers/core/resources/const_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:flutter/material.dart';

class AppHomeScreenGesture extends StatefulWidget {
  const AppHomeScreenGesture({super.key, required this.label, required this.iconData, required this.onTap});

  final String label;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  State<AppHomeScreenGesture> createState() => _AppHomeScreenGestureState();
}

class _AppHomeScreenGestureState extends State<AppHomeScreenGesture> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_){
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_){
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: ConstManager.c_300),
          padding: const EdgeInsets.all(SizeManager.s_8),
          decoration: BoxDecoration(
            border: Border.all(),
            color: isHovered ? Colors.purple : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(SizeManager.s_8),
            boxShadow: isHovered
                ? [
              const BoxShadow(
                color: Colors.black,
                blurRadius: SizeManager.s_10,
                spreadRadius: SizeManager.s_2,
                offset: Offset(SizeManager.s_0_0, SizeManager.s_5),
              ),
            ]
                : [],

          ),
          child: LayoutBuilder(
            builder: (context, constraints){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.iconData,
                    size: constraints.maxHeight * SizeManager.s_0_4,
                    color: Colors.purpleAccent,
                  ),
                  SizedBox(height: constraints.maxHeight * SizeManager.s_0_1,),
                  Text(widget.label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: constraints.maxHeight * 0.15,
                        color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

