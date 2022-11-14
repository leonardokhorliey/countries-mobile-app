
import 'dart:ui';
import 'package:countries_app/models/country.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CountryDetail extends StatefulWidget {
  final Country country;

  CountryDetail({Key? key,
    required this.country
  }) : super(key: key) {
    createState();
  }


  @override
  State<CountryDetail> createState() => _CountryDetailState(country: this.country);
}

class _CountryDetailState extends State<CountryDetail> {
  late Country country;
  int currentImageView = 1;
  List<String> dataPoints = ['Population', 'Region', 'Capital', 'Motto', 'Official Language', 'Ethnic Group', 'Region', 'Government',
  'Independence', 'Area', 'Currency', 'GDP', 'Time zone', 'Date format', 'Dialling Code', 'Driving Side'];

  Map<String, String> dataValues = Map();
  int dataCount = 0;

  _CountryDetailState({
    required this.country
  });

  @override
  void initState() {
    super.initState();

    setState(() {
      dataValues['Population'] = convertNumberToCommaSeparated(country.population);
      dataValues['Region'] = country.region;
      dataValues['Capital'] = country.capital;
      dataValues['Motto'] = country.motto;
      dataValues['Official Language'] = country.language;
      dataValues['Ethnic Group'] = '';
      dataValues['Region'] = country.region;
      dataValues['Government'] = country.government;
      dataValues['Independence'] = country.independence;
      dataValues['Area'] = '${
        convertNumberToCommaSeparated(country.area)
      }km2';
      dataValues['Currency'] = country.currency;
      dataValues['GDP'] = convertNumberToCommaSeparated(country.gdp);
      dataValues['Time zone'] = country.timezone;
      dataValues['Date format'] = country.dteformat;
      dataValues['Dialling Code'] = country.diallingCode;
      dataValues['Driving side'] = country.drivingSide;

    });

  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
          backgroundColor: const Color(0xFF000f24),
          body: SafeArea(
            child: Container (
                margin: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(

                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          Container(
                              height: 20,
                              child: Center(
                                  child: Text(country.name, style: TextStyle(color: Colors.white,fontSize: 15))
                              )
                          ),
                          Container(
                              height: 20,
                              width: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_sharp, color: Colors.white,),
                              )

                          ),
                        ],
                      ),
                    )
                    ,
                    Stack(
                      alignment: Alignment.center,

                      children: [
                        Stack(
                          alignment: Alignment(0, 1),
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 30),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Colors.red)
                                ),
                                child: Image(
                                  height: 200,
                                  width: 700,
                                  image: NetworkImage(
                                      currentImageView == 1 ? country.flagUrl :
                                      currentImageView == 2 ? country.logoUrl : country.mapUrl
                                  ),
                                )
                            ),
                            // Container(
                            //   child: Row(
                            //       children: [
                            //         Container(
                            //             width: 10,
                            //             height: 10,
                            //             decoration: BoxDecoration(
                            //                 shape: BoxShape.circle,
                            //                 color: Colors.white70
                            //             )
                            //         ),
                            //         Container(
                            //             width: 10,
                            //             height: 10,
                            //             decoration: BoxDecoration(
                            //                 shape: BoxShape.circle,
                            //                 color: Colors.white70
                            //             )
                            //         ),
                            //       ]
                            //   ),
                            // )

                          ],
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(currentImageView == 1) currentImageView = 3;
                                      currentImageView -= 1;
                                    });

                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white12,
                                    ),
                                    child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(currentImageView == 3) {
                                      currentImageView = 1;
                                      return;
                                    }
                                    currentImageView += 1;
                                    });

                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white12,
                                    ),
                                    child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                        )

                      ],
                    )
                    ,

                    Expanded(
                      child: SingleChildScrollView(
                          child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: dataValues.keys.map((data) {
                                  dataCount = (dataCount + 1) % 4;
                                  return Container(
                                    margin: EdgeInsets.only(bottom: dataCount == 0 ? 30 : 15),
                                    child: Row(

                                      children: [
                                        Text('$data: ', style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15
                                        ),),
                                        Text(dataValues[data] == '' ? 'N/A': dataValues[data] ?? '',style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15
                                        ))
                                      ],
                                    )
                                  );
                                }).toList()
                              )

                          )
                      )
                    )



                  ],
                )
            ),
          )
      );
    // } catch(e) {
    //   return Scaffold();
    // }

  }
}


String convertNumberToCommaSeparated(double number) {
  var numberToString = number.toString();
  var arr = numberToString.split('');
  var k = arr.length % 3;
  var newArr = [];

  int ctr = 0;
  int counter = 0;
  arr.forEach((num) {
    newArr.add(num);
    ctr = (ctr + 1) % 3;
    counter += 1;
    if (ctr == k && counter != arr.length) newArr.add(',');
  });

  return newArr.join();
}
