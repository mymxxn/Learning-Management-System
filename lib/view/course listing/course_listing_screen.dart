import 'package:flutter/material.dart';
import 'package:learning_management_system/controller/course_provider.dart';
import 'package:learning_management_system/view/course%20listing/course_card.dart';
import 'package:provider/provider.dart';

class CourseListingScreen extends StatefulWidget {
  const CourseListingScreen({super.key});

  @override
  State<CourseListingScreen> createState() => _CourseListingScreenState();
}

class _CourseListingScreenState extends State<CourseListingScreen> {
  late CourseProvider courseProvider;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
    courseProvider.fetchCourses();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        courseProvider.fetchCourses();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    courseProvider.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) {
            courseProvider.fetchCourses();
          },
        ),
Expanded(child:  courseProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: scrollController,
              itemCount: courseProvider.courses.length,
              itemBuilder: (context, index) {
                final course = courseProvider.courses[index];
                return CourseCard(course: course);
              },
            ),)
      ],
    );
  }
}
