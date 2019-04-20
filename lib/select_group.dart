import 'package:flutter/material.dart';

import 'select_item.dart';

enum SelectDirection { horizontal, vertical }
enum SelectStyle { circular, rectangle }
enum SelectType { single, multiple }

typedef OnSingleSelect<T> = Function(T value);
typedef OnMultipleSelect<T> = Function(List<T> values);

class SelectGroup<T> extends StatefulWidget {
  final SelectDirection direction;
  final SelectStyle style;
  final List<SelectItem<T>> items;
  final Color selectColor;
  final Color unSelectColor;
  final Color borderColor;
  final int index;
  final List<int> listIndex;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry space;
  final OnSingleSelect<T> onSingleSelect;
  final OnMultipleSelect<T> onMultipleSelect;
  final SelectType type;
  final bool isRepeatBorderLine;

  const SelectGroup(
      {Key key,
      @required this.items,
      this.direction = SelectDirection.horizontal,
      this.style = SelectStyle.circular,
      this.borderColor = Colors.blue,
      this.unSelectColor = Colors.white,
      this.selectColor = Colors.blue,
      this.type = SelectType.single,
      this.index,
      this.listIndex,
      this.onSingleSelect,
      this.onMultipleSelect,
      this.isRepeatBorderLine = false,
      this.space = const EdgeInsets.all(0.0),
      this.padding = const EdgeInsets.all(8.0)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _SelectGroupState<T>(this.index, listIndex != null ? listIndex : []);
}

class _SelectGroupState<T> extends State<SelectGroup<T>> {
  int index;

  List<int> selects;

  _SelectGroupState(this.index, this.selects);

  void onClickItem(int i) {
    if (widget.type == SelectType.single) {
      //单选
      setState(() {
        index = i;
      });
      widget.onSingleSelect(widget.items[i].value);
    } else {
      if (selects.contains(i)) {
        // 已经选中过
        setState(() {
          selects.removeAt(selects.indexOf(i));
        });
      } else {
        setState(() {
          selects.add(i);
        });
      }
      widget.onMultipleSelect(
          selects.map((value) => widget.items[value].value).toList());
    }
  }

  Flex buildContainer() {
    if (widget.direction == SelectDirection.horizontal) {
      return Row(
        children: buildItems(),
      );
    } else {
      return Column(
        children: buildItems(),
      );
    }
  }

  Widget buildItemCircular(int i, Color c, Color tc) {
    return GestureDetector(
      onTap: () {
        onClickItem(i);
      },
      child: Container(
        margin: widget.space,
        padding: widget.padding,
        decoration: BoxDecoration(
            color: c,
            shape: BoxShape.circle,
            border: Border.all(color: widget.borderColor)),
        child: Text(
          widget.items[i].label,
          style: TextStyle(color: tc),
        ),
      ),
    );
  }

  Border buildRectangleBorder(int i) {
    if (widget.isRepeatBorderLine || widget.items.length == 1) {
      return Border.all(color: widget.borderColor);
    } else {
      if (widget.direction == SelectDirection.vertical) {
        // 竖排

        if (widget.items.length == 2 && i == 0) {
          return Border(
              left: BorderSide(color: widget.borderColor),
              right: BorderSide(color: widget.borderColor),
              top: BorderSide(color: widget.borderColor));
        }

        if (widget.items.length == 2 && i == 1) {
          return Border.all(color: widget.borderColor);
        }

        if (widget.items.length > 2 &&
            (i == 0 || i == widget.items.length - 1)) {
          return Border.all(color: widget.borderColor);
        } else {
          if (widget.items.length == 3 || i == widget.items.length - 2) {
            return Border(
                left: BorderSide(color: widget.borderColor),
                right: BorderSide(color: widget.borderColor));
          } else {
            return Border(
                left: BorderSide(color: widget.borderColor),
                right: BorderSide(color: widget.borderColor),
                bottom: BorderSide(color: widget.borderColor));
          }
        }
      } else {
        if (widget.items.length == 2 && i == 0) {
          return Border(
              left: BorderSide(color: widget.borderColor),
              top: BorderSide(color: widget.borderColor),
              bottom: BorderSide(color: widget.borderColor));
        }
        if (widget.items.length == 2 && i == 1) {
          return Border.all(color: widget.borderColor);
        }

        if (widget.items.length > 2 &&
            (i == 0 || i == widget.items.length - 1)) {
          return Border.all(color: widget.borderColor);
        } else {
          if (widget.items.length == 3 || i == widget.items.length - 2) {
            return Border(
                top: BorderSide(color: widget.borderColor),
                bottom: BorderSide(color: widget.borderColor));
          } else {
            return Border(
                top: BorderSide(color: widget.borderColor),
                bottom: BorderSide(color: widget.borderColor),
                right: BorderSide(color: widget.borderColor));
          }
        }
      }
    }
  }

  Widget buildItemRectangle(int i, Color c, Color tc) {
    return GestureDetector(
      onTap: () {
        onClickItem(i);
      },
      child: Container(
        margin: widget.space,
        padding: widget.padding,
        decoration: BoxDecoration(
            color: c,
            shape: BoxShape.rectangle,
            border: buildRectangleBorder(i)),
        child: Text(
          widget.items[i].label,
          style: TextStyle(color: tc),
        ),
      ),
    );
  }

  Widget buildItem(int i) {
    if (widget.style == SelectStyle.circular) {
      if (i == index || selects.contains(i)) {
        return buildItemCircular(i, widget.selectColor, Colors.white);
      } else {
        return buildItemCircular(i, widget.unSelectColor, Colors.black);
      }
    } else {
      if (i == index || selects.contains(i)) {
        return buildItemRectangle(i, widget.selectColor, Colors.white);
      } else {
        return buildItemRectangle(i, widget.unSelectColor, Colors.black);
      }
    }
  }

  List<Widget> buildItems() {
    return List<Widget>.generate(
        widget.items.length, (index) => buildItem(index)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildContainer(),
    );
  }
}
