import 'package:api_data_fetch_practrice/fetch_data_with_model/helper/model_helper.dart';
import 'package:api_data_fetch_practrice/materials/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../model/paragraph_model.dart';

class WithModelHomePage extends StatefulWidget {
  const WithModelHomePage({super.key});

  @override
  State<WithModelHomePage> createState() => _WithModelHomePageState();
}

class _WithModelHomePageState extends State<WithModelHomePage> {
  List<ParagraphApi> paragraph = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await ParagraphModelHelper.getDataFetch();
      setState(() {
        paragraph = response;
        isLoading = false;
      });
    } catch (error) {
      showToast('Error: $error');
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paragraph List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: customColor.mainColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: isLoading
          ? ShimmerLoadingEffects()
          : RefreshIndicator(
              color: customColor.mainColor,
              onRefresh: () async {
                fetchData();
              },
              child: ListView.builder(
                itemCount: paragraph.length,
                itemBuilder: (_, index) {
                  final item = paragraph[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: customColor.secondColor,
                        child: Text(
                          item.id,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(item.title),
                      subtitle: Text(
                        item.paragraph,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget ShimmerLoadingEffects() {
    return ListView.builder(
      itemCount: paragraph.length,
      itemBuilder: (_, __) => Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Shimmer.fromColors(
            baseColor: customColor.simmerBgColor,
            highlightColor: customColor.simmerItemColor,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 250,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
