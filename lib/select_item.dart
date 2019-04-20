import 'package:flutter/material.dart';


class SelectItem<T> {
  String label;
  T value;

  SelectItem({@required this.label, @required this.value});

}