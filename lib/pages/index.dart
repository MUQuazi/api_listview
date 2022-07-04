import 'dart:convert';

import 'package:api_listview/theme/colors.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http ;

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.frtchUsers();
  }
frtchUsers() async {
  print("fetching");
  var url = Uri.parse("https://randomuser.me/api/?results=10");
  var response = await http.get(url);
  if (response.statusCode == 200){
    var items = json.decode(response.body)['results'];
    setState(() {
      users = items;
    });

  }else{
    setState(() {
      users = [];
    });
  }

  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listings Users"),
        ),
        body: getBody(),

      );
  }

  Widget getBody(){
    return ListView.builder(
      itemCount: users.length,
      itemBuilder:  (context, index) {
      return getCard(users[index]);
    }
    );
  }

  Widget getCard(item){
    var fullName =  item['name']['first'] + " " + item['name']['last'];
    var email = item["email"];
    var imageUrl = item['picture']['large'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageUrl.toString())),
                  ),
                  
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text(fullName,style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    Text(email,style: TextStyle(color: Colors.grey,fontSize: 17,fontWeight: FontWeight.normal)),

                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}