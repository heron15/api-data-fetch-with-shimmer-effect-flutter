import 'dart:convert';

import 'package:api_data_fetch_practrice/materials/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DirectApiHomeScreen extends StatefulWidget {
  const DirectApiHomeScreen({super.key});

  @override
  State<DirectApiHomeScreen> createState() => _DirectApiHomeScreenState();
}

class _DirectApiHomeScreenState extends State<DirectApiHomeScreen> {
  List<dynamic> paragraphList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchParagraphData();
  }

  void fetchParagraphData() async {
    setState(() {
      isLoading = true;
    });
    const url =
        'https://anticipatory-indust.000webhostapp.com/paragraph_app/paragraphResponse.php';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      paragraphList = json;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [customColor.secondColor, customColor.mainColor])),
        ),
        title: const Text('Api Data'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: customColor.mainColor,
            ))
          : SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  fetchParagraphData();
                },
                color: customColor.mainColor,
                child: ListView.builder(
                    itemCount: paragraphList.length,
                    itemBuilder: (_, index) {
                      final paragraph = paragraphList[index];
                      final id = paragraph['id'];
                      final title = paragraph['title'];
                      final paragraphData = paragraph['paragraph'];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: customColor.secondColor,
                            child: Text(
                              id,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(title),
                          subtitle: Text(
                            paragraphData,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
