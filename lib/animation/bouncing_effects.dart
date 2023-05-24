import 'package:flutter/material.dart';

// ! ANIMATION BUTTTON BOUCHIN
class Bouncing extends StatefulWidget {
  final Widget child;
  final VoidCallback onPress;
  final bool block;

  const Bouncing({
    Key? key,
    required this.child,
    required this.onPress,
    this.block = false,
  }) : super(key: key);

  @override
  State<Bouncing> createState() => _BouncingState();
}

class _BouncingState extends State<Bouncing>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: widget.block
          ? null
          : (PointerDownEvent event) {
              _controller!.forward();
            },
      onPointerUp: widget.block
          ? null
          : (PointerUpEvent event) {
              _controller!.reverse();
            },
      child: GestureDetector(
        onTap: widget.block ? null : () => widget.onPress(),
        child: Transform.scale(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}