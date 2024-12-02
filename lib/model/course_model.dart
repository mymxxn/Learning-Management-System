import 'dart:convert';

List<CourseModel> courseModelFromJson(String str) => List<CourseModel>.from(
    json.decode(str).map((x) => CourseModel.fromJson(x)));


class CourseModel {
  String? blocksUrl;
  String? effort;
  dynamic end;
  DateTime? enrollmentStart;
  DateTime? enrollmentEnd;
  String? id;
  Media? media;
  String? name;
  String? shortDescription;
  DateTime? start;
  String? startDisplay;
  bool? mobileAvailable;
  bool? hidden;
  bool? invitationOnly;
  String? courseId;

  CourseModel({
    this.blocksUrl,
    this.effort,
    this.end,
    this.enrollmentStart,
    this.enrollmentEnd,
    this.id,
    this.media,
    this.name,
    this.shortDescription,
    this.start,
    this.startDisplay,
    this.mobileAvailable,
    this.hidden,
    this.invitationOnly,
    this.courseId,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        blocksUrl: json["blocks_url"],
        effort: json["effort"],
        end: json["end"],
        enrollmentStart: json["enrollment_start"] == null
            ? null
            : DateTime.parse(json["enrollment_start"]),
        enrollmentEnd: json["enrollment_end"] == null
            ? null
            : DateTime.parse(json["enrollment_end"]),
        id: json["id"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        name: json["name"],
        shortDescription: json["short_description"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        startDisplay: json["start_display"],
        mobileAvailable: json["mobile_available"],
        hidden: json["hidden"],
        invitationOnly: json["invitation_only"],
        courseId: json["course_id"],
      );

  Map<String, dynamic> toJson() => {
        "blocks_url": blocksUrl,
        "effort": effort,
        "end": end,
        "enrollment_start": enrollmentStart?.toIso8601String(),
        "enrollment_end": enrollmentEnd?.toIso8601String(),
        "id": id,
        "media": media?.toJson(),
        "name": name,
        "short_description": shortDescription,
        "start": start?.toIso8601String(),
        "start_display": startDisplay,
        "mobile_available": mobileAvailable,
        "hidden": hidden,
        "invitation_only": invitationOnly,
        "course_id": courseId,
      };
}

class Media {
  BannerImage? bannerImage;
  Course? courseImage;
  Course? courseVideo;
  ImageModel? image;

  Media({
    this.bannerImage,
    this.courseImage,
    this.courseVideo,
    this.image,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        bannerImage: json["banner_image"] == null
            ? null
            : BannerImage.fromJson(json["banner_image"]),
        courseImage: json["course_image"] == null
            ? null
            : Course.fromJson(json["course_image"]),
        courseVideo: json["course_video"] == null
            ? null
            : Course.fromJson(json["course_video"]),
        image: json["image"] == null ? null : ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "banner_image": bannerImage?.toJson(),
        "course_image": courseImage?.toJson(),
        "course_video": courseVideo?.toJson(),
        "image": image?.toJson(),
      };
}

class BannerImage {
  String? uri;
  String? uriAbsolute;

  BannerImage({
    this.uri,
    this.uriAbsolute,
  });

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        uri: json["uri"],
        uriAbsolute: json["uri_absolute"],
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "uri_absolute": uriAbsolute,
      };
}

class Course {
  String? uri;

  Course({
    this.uri,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
      };
}

class ImageModel {
  String? raw;
  String? small;
  String? large;

  ImageModel({
    this.raw,
    this.small,
    this.large,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        raw: json["raw"],
        small: json["small"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "small": small,
        "large": large,
      };
}
