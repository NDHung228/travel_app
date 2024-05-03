import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Adjust the duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true); // Repeat the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            height: widget.height,
            width: widget.width,
            padding: const EdgeInsets.all(16 / 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          ),
        );
      },
    );
  }
}

class CircleSkeleton extends StatefulWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  _CircleSkeletonState createState() => _CircleSkeletonState();
}

class _CircleSkeletonState extends State<CircleSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Adjust the duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true); // Repeat the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
