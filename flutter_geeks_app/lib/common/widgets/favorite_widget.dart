import 'package:flutter/material.dart';

class GEFavoriteWidget extends StatefulWidget {
  bool favorite;
  final Function(bool) onTap;

  GEFavoriteWidget({Key? key, required this.favorite, required this.onTap})
      : super(key: key);

  @override
  State<GEFavoriteWidget> createState() => _GEFavoriteWidgetState();
}

class _GEFavoriteWidgetState extends State<GEFavoriteWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.favorite = !widget.favorite;
          widget.onTap(widget.favorite);
        });
      },
      child: Icon(
        Icons.favorite,
        color: widget.favorite ? Colors.red : Colors.grey,
        size: 24.0,
      ),
    );
  }

  _ontap() {}
}
