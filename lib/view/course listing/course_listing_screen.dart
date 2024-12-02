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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      courseProvider.fetchCourses();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        courseProvider.updatePage();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) {
              courseProvider.sortCourses(value);
            },
            decoration: InputDecoration(
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                filled: true,
                hintText: 'Search',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child:
                Consumer<CourseProvider>(builder: (context, provider, child) {
              return (provider.isLoading && provider.filteredCourses.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                  : provider.filteredCourses.isEmpty
                      ? const Center(
                          child: Text('No Data'),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: provider.filteredCourses.length + 1,
                          itemBuilder: (context, index) {
                            if (index == provider.filteredCourses.length) {
                              return provider.isLoading
                                  ? const Center(
                                      child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ))
                                  : const SizedBox.shrink();
                            } else {
                              return CourseCard(
                                  course: provider.filteredCourses[index]);
                            }
                          },
                        );
            }),
          )
        ],
      ),
    );
  }
}
