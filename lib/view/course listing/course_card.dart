import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/course_provider.dart';
import 'package:learning_management_system/model/course_model.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;

  const CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    return Card(
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: course.imageUrl != null
              ? Image.network(course.imageUrl ?? '',
                  width: 50, height: 50, fit: BoxFit.cover)
              : const Icon(Icons.image_not_supported),
        ),
        title: Text(course.title ?? ''),
        subtitle: Text(course.description ?? '',
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
