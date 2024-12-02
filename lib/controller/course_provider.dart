import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_management_system/model/course_model.dart';

class CourseProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<CourseModel> courses = [];
  List<CourseModel> filteredCourses = [];
  List<CourseModel> _bookmarkedCourses = [];
  bool isLoading = false;

  List<CourseModel> get bookmarkedCourses => _bookmarkedCourses;
  int pageNumber = 1;

  updatePage() {
    pageNumber++;
    notifyListeners();
  }

  sortCourses(String val) {
    filteredCourses = courses
        .where(
          (element) =>
              (element.name ?? '').toLowerCase().contains(val.toLowerCase()),
        )
        .toList();
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://courses.edx.org/api/courses/v1/courses/?page=${pageNumber}&page_size=20');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        if (pageNumber == 1) {
          courses = results.map((json) => CourseModel.fromJson(json)).toList();
        } else {
          courses.addAll(
              results.map((json) => CourseModel.fromJson(json)).toList());
        }
        filteredCourses = courses;
        if (searchController.text.isNotEmpty) {
          sortCourses(searchController.text);
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleBookmark(CourseModel course) {
    if (_bookmarkedCourses.contains(course)) {
      _bookmarkedCourses.remove(course);
    } else {
      _bookmarkedCourses.add(course);
    }
    notifyListeners();
  }
}
