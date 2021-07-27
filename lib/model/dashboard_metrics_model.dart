import 'dart:convert';

import 'package:flutter/material.dart';

class DashboardMetricsModel {
  String name;
  String svgSrc;
  Color color;
  int count;
  DashboardMetricsModel({
    required this.name,
    required this.svgSrc,
    required this.color,
    required this.count,
  });

  DashboardMetricsModel copyWith({
    String? name,
    String? svgSrc,
    Color? color,
    int? count,
  }) {
    return DashboardMetricsModel(
      name: name ?? this.name,
      svgSrc: svgSrc ?? this.svgSrc,
      color: color ?? this.color,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'svgSrc': svgSrc,
      'color': color.value,
      'count': count,
    };
  }

  factory DashboardMetricsModel.fromMap(Map<String, dynamic> map) {
    return DashboardMetricsModel(
      name: map['name'],
      svgSrc: map['svgSrc'],
      color: Color(map['color']),
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardMetricsModel.fromJson(String source) =>
      DashboardMetricsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DashboardMetricsModel(name: $name, svgSrc: $svgSrc, color: $color, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardMetricsModel &&
        other.name == name &&
        other.svgSrc == svgSrc &&
        other.color == color &&
        other.count == count;
  }

  @override
  int get hashCode {
    return name.hashCode ^ svgSrc.hashCode ^ color.hashCode ^ count.hashCode;
  }
}
