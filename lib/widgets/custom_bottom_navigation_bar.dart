import 'package:flutter/material.dart';

class CustomBottomAppBarItem {
  final String iconImagePath;
  CustomBottomAppBarItem({this.iconImagePath});
}

class CustomBottomNavigationBar extends StatefulWidget {
  final Color selectedColor;
  final Color color;
  final double height;
  final double iconSize;
  final List<CustomBottomAppBarItem> items;
  final ValueChanged<int> selectedIndex;
  final double iconActiveSize;

  CustomBottomNavigationBar({
    this.selectedColor,
    this.color,
    this.height,
    this.iconSize: 24,
    this.iconActiveSize: 32,
    this.items,
    this.selectedIndex,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
      widget.selectedIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: List.generate(widget.items.length, (index) {
          return _buildTabItem(
              item: widget.items[index], index: index, onPressed: _updateIndex);
        }),
      ),
    );
  }

  Widget _buildTabItem({
    CustomBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;

    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => onPressed(index),
            child: Center(
              child: ImageIcon(
                AssetImage(item.iconImagePath),
                color: color,
                size: _selectedIndex == index
                    ? widget.iconActiveSize
                    : widget.iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
