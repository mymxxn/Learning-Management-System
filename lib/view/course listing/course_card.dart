import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/course_provider.dart';
import 'package:learning_management_system/model/course_model.dart';
import 'package:provider/provider.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    return Card(
      child: ListTile(
        tileColor: Colors.white,
        leading: CachedNetworkImage(
          imageUrl: course.media!.image!.raw!,
          height: 50,
          width: 50,
          fit: BoxFit.fill,
          placeholder: (context, url) => const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
              child: Text(
            course.name?.substring(0, 2).toString().toUpperCase() ?? '',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )),
        ),
        title: Text(course.name ?? ''),
        subtitle: Text(course.shortDescription ?? '',
            maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: Icon(
            courseProvider.bookmarkedCourses.contains(course)
                ? Icons.bookmark
                : Icons.bookmark_border,
          ),
          onPressed: () {
            courseProvider.toggleBookmark(course);
          },
        ),
      ),
    );
  }
}
