import 'package:flutter/material.dart';

class SkSliderButton extends StatefulWidget {
  final double height;
  final double width;
  final double innerPadding;
  final Color backgroundColor;
  final Color backgroundProgressColor;
  final Color? backgroundColorEnd;
  final Color foregroundColor;
  final Color iconColor;
  final Widget sliderButtonContent;
  final BoxShadow? shadow;
  final BoxShadow foregroundShadow;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onConfirmation;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final BorderRadius? foregroundShape;
  final BorderRadius? backgroundShape;
  final bool stickToEnd;

  const SkSliderButton({
    Key? key,
    this.height = 70,
    this.width = 300,
    this.innerPadding = 5,
    this.backgroundColor = Colors.white,
    this.backgroundProgressColor = Colors.white,
    this.backgroundColorEnd,
    this.foregroundColor = Colors.blueAccent,
    this.iconColor = Colors.white,
    this.shadow,
    this.foregroundShadow = const BoxShadow(),
    this.sliderButtonContent = const Icon(
      Icons.chevron_right,
      color: Colors.white,
      size: 35,
    ),
    this.text = 'Slide to confirm',
    this.textStyle,
    required this.onConfirmation,
    this.onTapDown,
    this.onTapUp,
    this.foregroundShape,
    this.backgroundShape,
    this.stickToEnd = false,
  })  : assert(height >= 25 && width >= 250),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SkSliderButtonState();
  }
}

class SkSliderButtonState extends State<SkSliderButton> {
  double _position = 0;
  int _duration = 0;

  double getPosition() {
    if (_position < 0) {
      return 0;
    } else if (_position > widget.width - widget.height) {
      return widget.width - widget.height;
    } else {
      return _position;
    }
  }

  void updatePosition(dynamic details) {
    if (details is DragEndDetails) {
      setState(() {
        _duration = 600;
        if (widget.stickToEnd && _position > widget.width - widget.height) {
          _position = widget.width - widget.height;
        } else {
          _position = 0;
        }
      });
    } else if (details is DragUpdateDetails) {
      setState(() {
        _duration = 0;
        _position = details.localPosition.dx - (widget.height / 2);
      });
    }
  }

  void sliderReleased(dynamic details) {
    if (_position > widget.width - widget.height) {
      widget.onConfirmation();
    }
    updatePosition(details);
  }

  Color calculateBackground() {
    if (widget.backgroundColorEnd != null) {
      double percent;

      // calculates the percentage of the position of the slider
      if (_position > widget.width - widget.height) {
        percent = 1.0;
      } else if (_position / (widget.width - widget.height) > 0) {
        percent = _position / (widget.width - widget.height);
      } else {
        percent = 0.0;
      }

      int red = widget.backgroundColorEnd!.red;
      int green = widget.backgroundColorEnd!.green;
      int blue = widget.backgroundColorEnd!.blue;

      return Color.alphaBlend(
          Color.fromRGBO(red, green, blue, percent), widget.backgroundColor);
    } else {
      return widget.backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxShadow shadow;
    if (widget.shadow == null) {
      shadow = const BoxShadow(
        color: Colors.black38,
        offset: Offset(0, 2),
        blurRadius: 2,
      );
    } else {
      shadow = widget.shadow!;
    }

    TextStyle style;
    if (widget.textStyle == null) {
      style = const TextStyle(
        color: Colors.black26,
        fontWeight: FontWeight.bold,
      );
    } else {
      style = widget.textStyle!;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: _duration),
      curve: Curves.ease,
      height: widget.height,
      width: widget.width,
      padding: EdgeInsets.all(widget.innerPadding),
      decoration: BoxDecoration(
        borderRadius: widget.backgroundShape ??
            BorderRadius.all(Radius.circular(widget.height)),
        color: widget.backgroundColorEnd != null
            ? calculateBackground()
            : widget.backgroundColor,
        boxShadow: <BoxShadow>[shadow],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              widget.text,
              style: style,
            ),
          ),
          Positioned(
            left: 0,
            child: AnimatedContainer(
              height: widget.height - widget.innerPadding * 2,
              width: getPosition() + widget.height - widget.innerPadding * 2,
              duration: Duration(milliseconds: _duration),
              curve: Curves.ease,
              decoration: BoxDecoration(
                borderRadius: widget.backgroundShape ??
                    const BorderRadius.all(Radius.circular(1000)),
                color: widget.backgroundColorEnd != null
                    ? calculateBackground()
                    : widget.backgroundProgressColor,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: _duration),
            curve: Curves.bounceOut,
            left: getPosition(),
            top: 0,
            child: GestureDetector(
              onTapDown: (_) => widget.onTapDown ?? () {},
              onTapUp: (_) => widget.onTapUp ?? () {},
              onPanUpdate: (details) {
                updatePosition(details);
              },
              onPanEnd: (details) {
                widget.onTapUp?.call();
                sliderReleased(details);
              },
              child: Container(
                height: widget.height - widget.innerPadding * 2,
                width: widget.height - widget.innerPadding * 2,
                decoration: BoxDecoration(
                  boxShadow: [widget.foregroundShadow],
                  borderRadius: widget.foregroundShape ??
                      BorderRadius.all(Radius.circular(widget.height / 2)),
                  color: widget.foregroundColor,
                ),
                child: widget.sliderButtonContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
