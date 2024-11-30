import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_management_system/model/course_model.dart';

class CourseProvider with ChangeNotifier {
   final TextEditingController searchController = TextEditingController();
  List<CourseModel> _courses = [];
  List<CourseModel> _bookmarkedCourses = [];
  bool _isLoading = false;

  List<CourseModel> get courses => _courses;
  List<CourseModel> get bookmarkedCourses => _bookmarkedCourses;
  bool get isLoading => _isLoading;

  Future<void> fetchCourses() async {
    notifyListeners();

    final url = Uri.parse(
        'https://api.example.com/courses?search=${searchController.text}'); // Replace with actual API
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _courses = data.map((json) => CourseModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
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
