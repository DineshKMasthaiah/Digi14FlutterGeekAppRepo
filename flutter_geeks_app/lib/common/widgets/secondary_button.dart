import 'package:digi14_geeks_app/utils/ge_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GESecondaryButton extends StatefulWidget {
  final void Function()? onButtonPress;
  final String buttonText;
  final double width;
  final double height;
  final bool capitalize;
  final TextStyle style;

  const GESecondaryButton(
      {Key? key,
      required this.buttonText,
      this.onButtonPress,
      this.width = 80.0,
      this.height = 48.0,
      this.capitalize = false,
      this.style = GEStyles.secondaryButtonSmallTextStyle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GESecondaryButton();
}

class _GESecondaryButton extends State<GESecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onButtonPress,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Text(
          widget.buttonText,
          textAlign: TextAlign.left,
          style: widget.style,
          maxLines: 2,
        ),
      ),
    );
  }
}
