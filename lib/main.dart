
import 'package:countries_app/models/country.dart';
import 'package:countries_app/pages/landing_page.dart';
import 'package:flutter/foundation.dart';

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
      home: RenderGroup(),

    );
  }
}

class RenderGroup extends StatefulWidget {
  const RenderGroup({Key? key}) : super(key: key);

  @override
  State<RenderGroup> createState() => _RenderGroupState();
}

class _RenderGroupState extends State<RenderGroup> {
  bool isFilterSelected = false;
  Map<String, List<String>> filterFromFilterPane = {};
  List<String> continents = [];
  List<String> timezones = [];


  void setContinentsAndTimezones(Map<String, List<Country>> countriesGroup) {
    List<String> _continents = [];
    List<String> _timezones = [];
    countriesGroup.keys.forEach((ltr) {
      List<Country> countries = countriesGroup[ltr]!;
      countries.forEach((country) {
        if (!_continents.contains(country.region)) {
          _continents.add(country.region);
        }
        if (!_timezones.contains(country.timezone)) {
          _timezones.add(country.timezone);
        }
      });

    });

    setState(() {
      continents = _continents;
      timezones = _timezones;
    });
  }

  void setFiltersFromFilterPane(Map<String, List<String>> selectedFilterData) {
    setState(() {
      filterFromFilterPane = selectedFilterData;
    });
  }

  void setFilterPane(bool value) {
    setState(() {
      isFilterSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Landing(setCountries: (countriesGroup) {
          setContinentsAndTimezones(countriesGroup);
        },
        filterFromFilterPane: filterFromFilterPane,
        setFilterPane: setFilterPane),
        // isFilterSelected ? Stack(
        //   alignment: AlignmentDirectional.bottomCenter,
        //   children: [
        //     Scaffold(
        //       backgroundColor: Colors.white12,
        //
        //     ),
        //     FilterPane(sections: ['Continent', 'Timezone'],
        //       sectionsData: [continents, timezones],
        //       filterCountries: setFiltersFromFilterPane,
        //       setFilterPane: setFilterPane,)
        //   ],
        // ): Container()

      ]
    );
  }
}








