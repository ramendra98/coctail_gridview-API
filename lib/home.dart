import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var api = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail";
  var res, drinks;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    res = await http.get(api);
    drinks = jsonDecode(res.body)["drinks"];
    print(drinks..toString);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text('Coctail'),
      ),
      body: res != null
          ? GridView.builder(
              itemCount: drinks.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, index) {
                var drink = drinks[index];
                return Container(
                  child: InkWell(
                    onTap: () {
                      print(drink["strDrink"]);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                drink["strDrinkThumb"],
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(drink["strDrink"]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
    );
  }
}
