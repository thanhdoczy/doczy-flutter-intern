import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:hive/hive.dart';

part 'podcast.g.dart';

@HiveType(typeId: 2)
class PodCast extends Equatable{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final DateTime publishedDate;
  @HiveField(3)
  final String time;

  PodCast(this.title, this.image, this.publishedDate, this.time);
  
  @override
  // TODO: implement props
  List<Object?> get props => [title, image, publishedDate, time];
}