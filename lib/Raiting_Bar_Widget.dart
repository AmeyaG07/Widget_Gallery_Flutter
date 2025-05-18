import 'package:flutter/material.dart';

class HighEndRatingBar extends StatefulWidget {
  final double initialRating;
  final int starCount;
  final double maxWidth; // max width available to widget (for responsiveness)
  final ValueChanged<double>? onRatingChanged;
  final Color filledStarColor;
  final Color unfilledStarColor;

  const HighEndRatingBar({
    Key? key,
    this.initialRating = 0.0,
    this.starCount = 5,
    this.maxWidth = 300,
    this.onRatingChanged,
    this.filledStarColor = Colors.deepOrangeAccent,
    this.unfilledStarColor = Colors.grey,
  }) : super(key: key);

  @override
  State<HighEndRatingBar> createState() => _HighEndRatingBarState();
}

class _HighEndRatingBarState extends State<HighEndRatingBar> with TickerProviderStateMixin {
  late double _currentRating;
  late List<AnimationController> _starControllers;
  late List<Animation<double>> _scaleAnimations;
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating.clamp(0.0, widget.starCount.toDouble());

    _starControllers = List.generate(
      widget.starCount,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    _scaleAnimations = _starControllers
        .map((controller) =>
        Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack)))
        .toList();

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _colorAnimation = ColorTween(begin: widget.unfilledStarColor, end: widget.filledStarColor).animate(
      CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
    );

    // Initialize stars animation based on initial rating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateStars();
    });
  }

  @override
  void dispose() {
    for (final c in _starControllers) {
      c.dispose();
    }
    _colorController.dispose();
    super.dispose();
  }

  void _animateStars() {
    for (int i = 0; i < widget.starCount; i++) {
      if (_currentRating > i) {
        _starControllers[i].forward();
      } else {
        _starControllers[i].reverse();
      }
    }
    _colorController.forward().then((_) => _colorController.reverse());
  }

  void _updateRating(Offset localPosition, double starSize) {
    double rawRating = localPosition.dx / starSize;
    double newRating = (rawRating * 2).clamp(0, widget.starCount * 2).round() / 2;

    if (newRating != _currentRating) {
      setState(() {
        _currentRating = newRating;
      });
      _animateStars();
      if (widget.onRatingChanged != null) {
        widget.onRatingChanged!(newRating);
      }
    }
  }

  Widget _buildStar(int index, double size) {
    double fillAmount;
    if (_currentRating >= index + 1) {
      fillAmount = 1.0;
    } else if (_currentRating > index && _currentRating < index + 1) {
      fillAmount = _currentRating - index;
    } else {
      fillAmount = 0.0;
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_starControllers[index], _colorController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimations[index].value,
          child: Stack(
            children: [
              Icon(
                Icons.star,
                size: size,
                color: widget.unfilledStarColor.withOpacity(0.5),
                shadows: const [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              ClipRect(
                clipper: _StarClipper(fillAmount),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [
                        _colorAnimation.value ?? widget.filledStarColor,
                        (_colorAnimation.value ?? widget.filledStarColor).withOpacity(0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Icon(
                    Icons.star,
                    size: size,
                    color: Colors.amberAccent,
                    shadows: [
                      Shadow(
                        color: (_colorAnimation.value ?? widget.filledStarColor).withOpacity(0.6),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth < widget.maxWidth ? constraints.maxWidth : widget.maxWidth;
      final starSize = maxWidth / widget.starCount;

      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: (details) {
          RenderBox box = context.findRenderObject() as RenderBox;
          Offset localPosition = box.globalToLocal(details.globalPosition);
          _updateRating(localPosition, starSize);
        },
        onTapDown: (details) {
          RenderBox box = context.findRenderObject() as RenderBox;
          Offset localPosition = box.globalToLocal(details.globalPosition);
          _updateRating(localPosition, starSize);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.starCount, (index) => _buildStar(index, starSize)),
        ),
      );
    });
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fillPercent;

  _StarClipper(this.fillPercent);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fillPercent, size.height);
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) {
    return oldClipper.fillPercent != fillPercent;
  }
}
