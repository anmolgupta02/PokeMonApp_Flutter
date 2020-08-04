import 'package:flutter/material.dart';
import 'package:pokeapp/Pokemon.dart';

class PokeDetails extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetails({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        title: Text(pokemon.name),
        elevation: 0.0,
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) =>
    Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height/1.5,
          width: MediaQuery.of(context).size.width-20,
          left: 10,
          top: MediaQuery.of(context).size.height*0.1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 100,),
                Text(pokemon.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
                ),),
                Text("Height : ${pokemon.height}"),
                Text("Wight : ${pokemon.weight}"),
                Text("Types"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((e) =>
                            FilterChip(label: Text(e),
                                backgroundColor: Colors.amber,
                                onSelected: (b) {}))
                        .toList()),
                Text("Weakness"),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((e) =>
                        FilterChip(label: Text(e, style: TextStyle(
                          color: Colors.white
                        ),),
                            backgroundColor: Colors.red,
                            onSelected: (b) {}))
                        .toList()),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(pokemon.img),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
        )

      ],
    );

}
