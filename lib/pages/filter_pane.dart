
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef FilterCountriesCallback = Function(Map<String, List<String>> selections);
typedef FilterPaneSetter = Function(bool);

class FilterPane extends StatefulWidget {
  final List<String> sections;
  final List<List<String>> sectionsData;
  final FilterCountriesCallback filterCountries;
  final FilterPaneSetter setFilterPane;
  const FilterPane({Key? key, required this.sections, required this.sectionsData, required this.filterCountries, required this.setFilterPane}) : super(key: key);

  @override
  State<FilterPane> createState() => _FilterPaneState(sections: sections, sectionsData: sectionsData, filterCountries: filterCountries);
}

class _FilterPaneState extends State<FilterPane> {
  Map<String, List<String>> selectedFilterData = Map();
  List<String> sections;
  List<List<String>> sectionsData;
  FilterCountriesCallback filterCountries;

  _FilterPaneState({required this.sections, required this.sectionsData, required this.filterCountries}) {
    sections.forEach((section) {
      selectedFilterData[section] = [];
    });
  }

  void setSelectedFilters(String section, String selection, bool isAdd) {
    setState(() {
      isAdd ?
      selectedFilterData[section]?.add(selection) : selectedFilterData[section]?.remove(selection);
    });

  }

  void resetFilters() {
    setState(() {
      selectedFilterData.keys.forEach((section){
        selectedFilterData[section] = [] ;
      });
    });

  }

  void setFilter() {
    filterCountries(selectedFilterData);
    widget.setFilterPane(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Color(0xFF000f24),

        ),
      child: Column(
        children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filter', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                        widget.setFilterPane(false);
                    },
                      child: Container(
                        padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xFF000f24),

                          ),
                        child: Text('x', style: TextStyle(color: Colors.white, fontSize: 10))

                      )
                  )

                ],
              ),

            ),
            Column(
              children: sections.map((section) {
                List<String> data =  sectionsData.elementAt(sections.indexOf(section));
                // print('Section: $data');
                List<String> selectedData = selectedFilterData[section]!;
                return FilterPaneSection(sectionHeading: section,
                    sectionData: data,
                    selectedData: selectedData,
                    setFilters: (section, selection, add) {
                      setSelectedFilters(section, selection, add);
                    });
              }).toList(),

            ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                    child: GestureDetector(
                      onTap: (){
                        resetFilters();
                      },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.white)

                      ),
                      child: Text('Reset', style: TextStyle(color: Colors.white, fontSize: 10)),
                    )
                )),
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 5,
                    child: GestureDetector(
                      onTap: (){
                        filterCountries(selectedFilterData);
                      },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFFcc5807),

                      ),
                      child: Center(
                        child: Text('Show Results', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    )
                ))

              ],
            )
          )

        ]
      )
    );
  }
}

typedef FilterCallback = Function(String section, String selection, bool add);


class FilterPaneSection extends StatefulWidget {
  final String sectionHeading;
  final List<String> sectionData;
  final List<String> selectedData;
  final FilterCallback setFilters;

  const FilterPaneSection({Key? key,
    required this.sectionHeading,
    required this.sectionData,
    required this.selectedData,
    required this.setFilters}) : super(key: key);

  @override
  State<FilterPaneSection> createState() => _FilterPaneSectionState(
    sectionHeading: sectionHeading,
    sectionData: sectionData,
    selectedData: selectedData,
    setFilter: setFilters
  );
}

class _FilterPaneSectionState extends State<FilterPaneSection> {
  bool isSectionActive = false;
  String sectionHeading;
  List<String> sectionData;
  List<String> selectedData;
  List<String> selectedOptions = [];
  FilterCallback setFilter;

  _FilterPaneSectionState({required this.sectionHeading, required this.sectionData, required this.selectedData, required this.setFilter});


  @override
  Widget build(BuildContext context) {
    // print('Section section: $sectionData');
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sectionHeading, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSectionActive = !isSectionActive;
                    });
                  },
                  child: Icon(isSectionActive ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white,)
                )

              ]
            )
          ),
          Container(
            child: Column(
              children: sectionData.map((data) => Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data, style: TextStyle(color: Colors.white, fontSize: 12)),
                      Checkbox(value: selectedData.contains(data), onChanged: (bool? newValue) {

                        setFilter(sectionHeading, data, newValue!);
                      })
                    ]
                  )
              )).toList(),
            )
          )
        ],
      )
    );
  }
}

