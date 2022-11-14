
import 'dart:convert';
import 'dart:ui';
import 'package:countries_app/models/country.dart';
import 'package:countries_app/pages/country_detail.dart';
import 'package:countries_app/pages/filter_pane.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Landing extends StatefulWidget {
  final CountriesUploadCallback setCountries;
  final Map<String, List<String>> filterFromFilterPane;
  final FilterPaneSetter setFilterPane;
  const Landing(
      {Key? key,
      required this.setCountries,
      required this.filterFromFilterPane,
      required this.setFilterPane}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF000f24),
        body: SafeArea(
            child: Column(
              children: [
                Expanded(

                    child: LandingCover(setCountries: widget.setCountries,
                      filterFromFilterPane: widget.filterFromFilterPane,
                      setFilterPane: widget.setFilterPane,)
                )
              ],
            )


        )
    );
  }
}


class LandingCover extends StatefulWidget {
  final CountriesUploadCallback setCountries;
  final Map<String, List<String>> filterFromFilterPane;
  final FilterPaneSetter setFilterPane;
  const LandingCover({Key? key, required this.setCountries, required this.filterFromFilterPane, required this.setFilterPane}) : super(key: key);

  @override
  State<LandingCover> createState() => _LandingCoverState();
}

class _LandingCoverState extends State<LandingCover> {
  String? filterString;


  @override
  Widget build(BuildContext context) {
    // print(filterString ?? '');
    return Container(

        margin: const EdgeInsets.all(30),
        child: Column(

            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CountryDetail(country: Country.empty())),
                  );
                },
                child: Container(

                    child: Row(
                        children: const [
                          Text('Explore.',
                              style: TextStyle(fontFamily: 'Elsie Swash Caps', color: Colors.white,fontSize: 50)),

                        ]
                    )
                ),
              ),

              SearchBar(callback: (String searchQuery) {
                // print('$searchQuery got here');
                setState(() {
                  filterString = searchQuery;
                });
              },),

              Container(

                  margin: EdgeInsets.symmetric(vertical: 20),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.white)
                              ),

                              width: 70,
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
                      GestureDetector(
                        onTap: () {
                          widget.setFilterPane(true);
                        },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.white)
                              ),
                              width: 70,
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

              Countries(filterString: filterString ?? '', setCountriesGrp: widget.setCountries, filterFromFilterPane: widget.filterFromFilterPane,)

            ]
        )
    );
  }
}


typedef CountryCallback = void Function(Country val);

class CountryLine extends StatefulWidget {
  final Country country;
  // final CountryCallback setSelectedCountry;

  CountryLine({Key? key,
    required this.country,
    // required this.setSelectedCountry
  }) : super(key: key) {
    createState();
  }

  @override
  State<CountryLine> createState() => _CountryLineState(country: this.country);
}

class _CountryLineState extends State<CountryLine> {

  final Country country;
  // final CountryCallback setSelectedCountry;

  _CountryLineState({
    required this.country,
    // required this.setSelectedCountry
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        child: GestureDetector(
          onTap: () {
            // setSelectedCountry(country);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CountryDetail(country: this.country)),
            );
          },
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
          ),
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


typedef CountriesUploadCallback = Function(Map<String, List<Country>> countries);

class Countries extends StatefulWidget {
  String filterString;
  CountriesUploadCallback setCountriesGrp;
  Map<String, List<String>> filterFromFilterPane;
  Countries({Key? key, required this.filterString, required this.setCountriesGrp, required this.filterFromFilterPane}) : super(key: key) {

  }


  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  late Map<String, List<Country>> countries;

  _CountriesState() {
    // print('Bygones');
      try {
        Map<String, List<Country>> cont = {};
        countries.keys.forEach((ltr){
          cont[ltr] = countries[ltr]!.where((c) => c.name.contains(widget.filterString)).toList();
        });
        // print(cont);
        setState(() {
          countries = cont;
        });
        widget.setCountriesGrp(cont);
      } catch (e) {

      }
  }

  @override
  void initState() {
    // print('Passed Here first');
    super.initState();
    fetchCountriesMap();
  }

  void fetchCountriesMap() async {
    // print('Filtering with: ${widget.filterString}');
    var c = await fetchCountries(widget.filterString, widget.filterFromFilterPane);

    // print('Passed Here  2');
    // print(c);

    setState(() {
      countries = c;
    });


  }

  @override
  Widget build(BuildContext context) {
    // print('Building: ${widget.filterString}');
    fetchCountriesMap();

    try {
      return Expanded(child:

      SingleChildScrollView(

          child: Column(
              children:
              countries.keys.map((letter) {

                return (countries[letter]!.isNotEmpty) ?
                CountriesGroup(firstLetter: letter, countries: countries[letter]?? []):
                Container();
              }).toList()
          )
      ));
    } catch (e) {
      return Container();
    }

  }
}

typedef SearchCallback = void Function(String val);

class SearchBar extends StatefulWidget {
  final SearchCallback callback;
  const SearchBar({Key? key, required this.callback}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState(callback: callback);
}

class _SearchBarState extends State<SearchBar> {
  String searchQuery = "";
  late SearchCallback callback;

  _SearchBarState({required this.callback});

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
                  callback(text);

                },
              ),
            )
          ],
        )


    );
  }
}

Future<Map<String, List<Country>>> fetchCountries(String? filterString, Map<String, List<String>> filterPane) async {
  // print('Filter: $filterString');
  final response = await http
      .get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (kDebugMode) {
      print(response);
    }

    List<String> continentFilters = filterPane['Continent'] ?? [];
    List<String> timezoneFilters = filterPane['Timezone'] ?? [];

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
        
        if (continentFilters.isNotEmpty || timezoneFilters.isNotEmpty) {
          if (continentFilters.contains(c.region) || timezoneFilters.contains(c.timezone)) {
            if (filterString == '') {
              countriesGroup[c.name[0].toUpperCase()]?.add(c);

            } else if (c.name.toLowerCase().contains(filterString!)) {
              countriesGroup[c.name[0].toUpperCase()]?.add(c);
            }
          }
        } else {
          if (filterString == '') {
            countriesGroup[c.name[0].toUpperCase()]?.add(c);

          } else if (c.name.toLowerCase().contains(filterString!)) {
            countriesGroup[c.name[0].toUpperCase()]?.add(c);
          }
        }
          
        
      } catch (e) {




      }


    });
    // print('Passed Here');
    // print(countriesGroup);
    return countriesGroup;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
