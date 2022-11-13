import 'dart:convert';
import 'dart:ui';
import 'package:countries_app/models/country.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF000f24),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(

                  child: Container(

                      margin: const EdgeInsets.all(30),
                      child: Column(

                          children: [
                            Container(

                                child: Row(
                                    children: const [
                                      Text('Explore.',
                                          style: TextStyle(fontFamily: 'Elsie Swash Caps', color: Colors.white,fontSize: 50)),

                                    ]
                                )
                            ),
                            SearchBar(),

                            Container(

                                margin: EdgeInsets.symmetric(vertical: 20),
                                child:
                                Row(

                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                color: Colors.transparent,
                                                border: Border.all(color: Colors.white)
                                            ),

                                            width: 50,
                                            padding: const EdgeInsets.all(2),
                                            child: Center(
                                              widthFactor: 20,
                                              child: Row(
                                                  children: const [
                                                    Icon(Icons.search, color: Colors.white,),
                                                    Text('EN', style: TextStyle(color: Colors.white))
                                                  ]

                                              ),
                                            )

                                        )
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: SizedBox(

                                        )
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                color: Colors.transparent,
                                                border: Border.all(color: Colors.white)
                                            ),
                                            width: 50,
                                            padding: const EdgeInsets.all(2),
                                            child:
                                            Row(
                                                children: const [
                                                  Icon(Icons.filter_7_sharp, color: Colors.white,),
                                                  Text('Filter', style: TextStyle(color: Colors.white))
                                                ]

                                            )
                                        )
                                    ),

                                  ],
                                )
                            ),

                            Countries()

                          ]
                      )
                  )
              )
            ],
          )


        )
      )
      ,
    );
  }
}

class CountryLine extends StatefulWidget {
  final Country country;

  CountryLine({Key? key,
    required this.country
  }) : super(key: key) {
    createState();
  }

  @override
  State<CountryLine> createState() => _CountryLineState(country: this.country);
}

class _CountryLineState extends State<CountryLine> {

  final Country country;

  _CountryLineState({
    required this.country
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.grey[300],
              ),
              child: Image(
                image: NetworkImage(country.flagUrl),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(country.name, style: TextStyle(color: Colors.white, fontSize: 15)),
                Text(country.capital, style: TextStyle(color: Colors.white38, fontSize: 15)),
              ],
            )

          ],
        )
    );
  }
}


class CountriesGroup extends StatefulWidget {
  final String firstLetter;
  final List<Country> countries;

  CountriesGroup({Key? key,
    required this.firstLetter,
    required this.countries
  }) : super(key: key) {
    createState();
  }

  @override
  State<CountriesGroup> createState() => _CountriesGroupState(firstLetter: this.firstLetter, countries: this.countries);
}

class _CountriesGroupState extends State<CountriesGroup> {
  final String firstLetter;
  final List<Country> countries;

  _CountriesGroupState({
    required this.firstLetter,
    required this.countries
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: Text(firstLetter, style: TextStyle(color: Colors.white)),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: countries.map((country) => CountryLine(country: country)).toList()
          )
        ]
    );
  }
}


class Countries extends StatefulWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  late Map<String, List<Country>> countries;

  @override
  void initState() {
    print('Passed Here first');
    super.initState();
    fetchCountriesMap();
  }

  void fetchCountriesMap() async {
    var c = await fetchCountries();
    print('Passed Here  2');
    setState(() {
      countries = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Expanded(child:

        SingleChildScrollView(

          child: Column(
              children:
              countries.keys.map((letter) {
                return CountriesGroup(firstLetter: letter, countries: countries[letter]?? []);
              }).toList()
          )
      ));
    } catch (e) {
      return Container();
    }

  }
}


class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: Colors.white70),
          color: const Color(0xFF1e2c41),
        ),
        margin: const EdgeInsets.only(top: 20),

        child: Row(

          children:
          [
            Expanded(
              flex: 1,
              child: Icon(Icons.search_rounded, color: Colors.white,),
            ),

            Expanded(
              flex: 9,
                child: TextField(
                  selectionWidthStyle: BoxWidthStyle.max,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Search Country',
                    hintStyle: TextStyle(color: Colors.white38)

                  ),
                  onChanged: (text){
                    setState(() {
                      searchQuery = text;
                    });
                  },
                ),
            )
          ],
        )


    );
  }
}

Future<Map<String, List<Country>>> fetchCountries() async {
  final response = await http
      .get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (kDebugMode) {
      print(response);
    }

    List<String> lettersOfAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

    List<dynamic> responseList = jsonDecode(response.body);


    Map<String, List<Country>> countriesGroup = {};
    lettersOfAlphabet.forEach((letter) {
      countriesGroup[letter] = [];
    });

    var counting = 0;
    responseList.forEach((country) {
      // Country c = Country.fromJson(country);
      // countriesGroup[c.name[0].toUpperCase()]?.add(c);

      try {
        Country c = Country.fromJson(country);
        countriesGroup[c.name[0].toUpperCase()]?.add(c);
      } catch (e) {

        counting += 1;
        if(counting == 1) print(country);


      }


      });
    print('Passed Here');
    return countriesGroup;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



