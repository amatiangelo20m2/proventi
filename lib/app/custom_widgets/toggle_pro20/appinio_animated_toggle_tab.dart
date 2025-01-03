library appinio_animated_toggle_tab;

import 'package:flutter/material.dart';

class SwitchPro20 extends StatefulWidget {
  /// function(int) for call back and control the view of tabs
  final Function(int) callback;

  /// a list of texts displayed on the tabs
  final List<Widget> tabTexts;

  /// style of text when active
  final TextStyle activeStyle;

  /// style of text when inactive
  final TextStyle inactiveStyle;

  /// height of the tab
  final double height;

  /// decoration of the tab
  final BoxDecoration boxDecoration;

  /// the decoration of animated box used to toggle
  final BoxDecoration animatedBoxDecoration;

  /// width of the tab
  final double width;

  /// offset of the area to toggle
  final double offset;

  /// animation duration for the toggling
  final Duration duration;

  final int initialIndex;

  const SwitchPro20({
    Key? key,
    required this.callback,
    required this.tabTexts,
    required this.height,
    required this.boxDecoration,
    required this.animatedBoxDecoration,
    required this.activeStyle,
    required this.inactiveStyle,
    required this.width,
    this.offset = 0.02,
    this.duration = const Duration(milliseconds: 100),
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchPro20State();
}

class _SwitchPro20State extends State<SwitchPro20> {
  late int index;

  _SwitchPro20State() : super();

  @override
  void initState() {
    super.initState();

    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: widget.boxDecoration,
      child: Stack(children: [
        AnimatedAlign(
          alignment: Alignment(
              (index / (widget.tabTexts.length - 1) * (2 - 2 * widget.offset)) -
                  1 +
                  widget.offset,
              0),
          duration: widget.duration,
          child: Container(

            width: (widget.width / widget.tabTexts.length),
            height: widget.height * 0.9,
            decoration: widget.animatedBoxDecoration,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.tabTexts.length; i++)
              _buildSwitchTab(
                i == index,
                widget.tabTexts[i],
                i == index ? widget.activeStyle : widget.inactiveStyle,
                i,
              ),
          ],
        ),
      ]),
    );
  }

  /// building and returning one item of the tab
  Widget _buildSwitchTab(
    bool isLeft,
    Widget title,
    TextStyle style,
    int i,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          index = i;
          widget.callback(i);
        });
      },
      child: Container(
          alignment: Alignment.center,
          width: widget.width / widget.tabTexts.length,
          height: widget.height,
          child: title),
    );
  }
}
