import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:pokeapp/Pokemon.dart';
import 'dart:convert';
import 'package:pokeapp/pokedetails.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
        home: HomePage(),
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String BaseURL =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(BaseURL);
    var DecodedValue = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(DecodedValue);
    print(pokeHub);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Poke App'),
      ),
      drawer: Drawer(),
      body: pokeHub == null
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
        crossAxisCount: 2, //used conditional statements
        children: pokeHub.pokemon
            .map((Pokemon poke) =>
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PokeDetails(
                                pokemon: poke,
                              )));
                },
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Hero(
                        tag: poke.img,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(poke.img))),
                        ),
                      ),
                      Text(
                        poke.name,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: Icon(Icons.refresh /**/),
      ),
    );
  }
}
