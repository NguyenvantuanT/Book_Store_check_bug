import 'dart:convert';

import 'package:book_app/models/book_model.dart';

DetailBookModel detailModelFromJson(String str) => DetailBookModel.fromJson(json.decode(str));
String detailModelToJson(DetailBookModel data) => json.encode(data.toJson());

class DetailBookModel {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo? volumeInfo;
  final SaleInfo? saleInfo;
  final AccessInfo? accessInfo;

  DetailBookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
  });

  factory DetailBookModel.fromJson(Map<String,dynamic> json) => DetailBookModel(
    kind: json['kind'] ?? "",
    id : json['id'],
    etag: json['etag'],
    selfLink: json['selfLink'],
    volumeInfo: json['volumeInfo'] != null ? VolumeInfo.fromJson(json['volumeInfo']) : null,
    saleInfo: json['saleInfo'] != null ? SaleInfo.fromJson(json['saleInfo']) : null,
    accessInfo: json['accessInfo'] != null ? AccessInfo.fromJson(json['accessInfo']) : null,
  );


  Map<String,dynamic> toJson() => {
    'kind': kind,
    'id': id,
    'etag': etag,
    'selfLink': selfLink,
    'volumeInfo': volumeInfo,
    'saleInfo': saleInfo,
    'accessInfo': accessInfo,
  };
}

