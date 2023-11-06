import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTimeLine extends StatelessWidget {
  const CustomTimeLine({
    Key? key,
    required this.itemCount,
    this.separatorHeightBuilder,
    this.separatorColor,
    this.iconColor,
    required this.builder,
    required this.iconBuilder,
    this.separator,
    this.separatorWidth,
    this.horizontalSpace,
    this.separatorBuilder,
  }) : super(key: key);
  final int itemCount;
  final double Function(int)? separatorHeightBuilder;
  final double? separatorWidth;
  final double? horizontalSpace;
  final bool? separator;
  final Color? separatorColor;
  final Color? iconColor;
  final Widget Function(BuildContext context, int idx) builder;
  final Widget Function(BuildContext context, int idx)? separatorBuilder;
  final Widget Function(BuildContext context, int idx) iconBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        itemCount,
        (idx) {
          return SizedBox(
            width: double.infinity,
            //color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      iconBuilder(context, idx),
                      if (separator != false)
                        if (separatorBuilder == null)
                          const VerticalDivider(
                            width: 5,
                            color: Colors.black,
                          )
                        // Container(
                        //   width: separatorWidth ?? 2,
                        //   // height: separatorHeightBuilder!(idx),
                        //   //height: double.infinity,
                        //   color: separatorColor ?? Colors.black,
                        // )
                        else
                          separatorBuilder!(context, idx),
                    ],
                  ),
                ),
                SizedBox(width: horizontalSpace ?? 40),
                Expanded(child: builder(context, idx)),
              ],
            ),
          );
        },
      ),
    );
  }
}
