import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? stringRespone;
  Map? mapResponse;
  List? listOfFacts;

  Future fetchData() async {
    var url = Uri.parse("https://www.thegrowingdeveloper.org/apiview?id=2");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listOfFacts = mapResponse!['facts'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetching Data with String Response'),
          backgroundColor: Colors.blue,
        ),
        body: mapResponse == null
            ? Container()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        mapResponse!['category'].toString(),
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                      listOfFacts![index]['image_url']),
                                  Text(
                                    listOfFacts![index]['title'].toString(),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    listOfFacts![index]['description']
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount:
                              listOfFacts == null ? 0 : listOfFacts!.length)
                    ],
                  ),
                ),
              ));
  }
}
