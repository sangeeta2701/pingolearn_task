import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingolearn_task/Widgets/sizedbox.dart';
import 'package:pingolearn_task/model/newsListData.dart';
import 'package:pingolearn_task/utils/colors.dart';
import 'package:pingolearn_task/utils/constant.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String API_KEY = "00a3bb0bad3c4dbbb7f644fde89befe2";
  @override
  void initState() {
    super.initState();
    _getNewsList();
  }

  List<Article> newsList = [];
  Future<void> _getNewsList() async {
    final response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=2024-06-17&sortBy=publishedAt&apiKey=00a3bb0bad3c4dbbb7f644fde89befe2"),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var _news = newsListDataFromJson(response.body);

      setState(() {
        newsList = _news.articles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themeColor,
        title: Text(
          "MyNews",
          style: buttonStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.near_me,
                color: wColor,
                size: 16.sp,
              )),
          Text(
            "IN",
            style: buttonStyle,
          ),
          width20,
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Top Headlines",
                style: blackHeadingStyle,
              ),
              height12,
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child:newsList.isEmpty?Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(themeColor),),): ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: wColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsList[index].title,
                                        style: blackHeadingStyle,
                                        maxLines: 1,
                                      ),
                                      height4,
                                      Text(
                                        newsList[index].content,
                                        style: blackContentStyle,
                                        maxLines: 3,
                                      )
                                    ],
                                  ),
                                ),
                                width12,
                                Container(
                                  constraints: BoxConstraints(
                                      maxHeight: 100,
                                      maxWidth: 100,
                                      minHeight: 80,
                                      minWidth: 80),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(image: NetworkImage(newsList[index].urlToImage!),fit: BoxFit.cover)),
                                ),
                              ]),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
