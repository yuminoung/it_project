import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget leading;
  final Widget trailing;
  final String title;

  CustomAppBar({
    Key key,
    @required this.title,
    this.height = 60,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          height: height,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: leading ?? Container(),
              ),
              Expanded(
                flex: 2,
                child: AutoSizeText(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 1,
                child: trailing ?? Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
