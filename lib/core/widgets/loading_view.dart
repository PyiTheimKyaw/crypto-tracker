import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 6,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppSemanticColors semantic = context.semantic;
    final Color base = semantic.tileBackground;
    final Color highlight =
        Color.lerp(base, semantic.tileBorder, 0.9) ?? base;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? _) {
        final double t = _controller.value;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 + 2 * t, 0),
              end: Alignment(0.0 + 2 * t, 0),
              colors: <Color>[base, highlight, base],
              stops: const <double>[0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        );
      },
    );
  }
}

class MarketLoadingView extends StatelessWidget {
  const MarketLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ShimmerBox(width: double.infinity, height: 76, radius: 14),
          SizedBox(height: 16),
          _ShimmerLabelRow(),
          SizedBox(height: 8),
          _ShimmerCarouselRow(),
          SizedBox(height: 16),
          ShimmerBox(width: double.infinity, height: 44, radius: 28),
          SizedBox(height: 16),
          _ShimmerListItem(),
          _ShimmerListItem(),
          _ShimmerListItem(),
          _ShimmerListItem(),
        ],
      ),
    );
  }
}

class _ShimmerLabelRow extends StatelessWidget {
  const _ShimmerLabelRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        ShimmerBox(width: 96, height: 10),
        Spacer(),
        ShimmerBox(width: 64, height: 10),
      ],
    );
  }
}

class _ShimmerCarouselRow extends StatelessWidget {
  const _ShimmerCarouselRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, _) =>
            const ShimmerBox(width: 200, height: 96, radius: 12),
      ),
    );
  }
}

class _ShimmerListItem extends StatelessWidget {
  const _ShimmerListItem();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          ShimmerBox(width: 16, height: 12),
          SizedBox(width: 12),
          ShimmerBox(width: 36, height: 36, radius: 18),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ShimmerBox(width: 96, height: 12),
                SizedBox(height: 6),
                ShimmerBox(width: 140, height: 10),
              ],
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ShimmerBox(width: 80, height: 14),
              SizedBox(height: 6),
              ShimmerBox(width: 48, height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
