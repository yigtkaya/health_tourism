import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/product/theme/styles.dart';

import '../../../cubit/clinic/clinic_cubit.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  RangeValues values = const RangeValues(0.0, 5.0);

  final FocusNode _searchFieldFocusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  List<String> filteredCities = [];
  List<String> turkishCities = [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Isparta',
    'Mersin',
    'İstanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce',
  ];

  void selectSuggestion(String selectedCity) {
    setState(() {
      controller.text = selectedCity;
      // Set the selected suggestion as the result and clear the search field
      _searchFieldFocusNode.unfocus();
      filteredCities.clear(); // Clear the filtered results
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    RangeLabels labels =
        RangeLabels(values.start.toString(), values.end.toString());

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _searchFieldFocusNode.unfocus();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HTText(label: "Rating range", style: htDarkBlueBoldLargeStyle),
              RangeSlider(
                values: values,
                divisions: 10,
                min: 0.0,
                max: 5.0,
                labels: labels,
                onChanged: (newValues) {
                  setState(() {
                    values = newValues;
                  });
                },
              ),
              HTText(label: "Location", style: htDarkBlueBoldLargeStyle),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      // When the text in the TextField changes, filter the list
                      setState(() {
                        filteredCities = turkishCities
                            .where((city) => city.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    focusNode: _searchFieldFocusNode,
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Search for a city',
                      labelStyle: htDarkBlueLargeStyle,
                    ),
                  ),
                ),
              ),
              filteredCities.isEmpty ? const SizedBox.shrink() : Container(
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.15,
                ),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: filteredCities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(filteredCities[index]),
                        onTap: () {
                          // Call the selectSuggestion method when a suggestion is tapped
                          selectSuggestion(filteredCities[index]);
                        },
                      );
                    },
                  ),
                ),
              ),
              const VerticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                        controller.clear();
                        setState(() {
                          values = const RangeValues(0.0, 5.0);
                        });
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: HTText(
                                label: 'clear all filters',
                                style: htBlueLabelStyle.copyWith(
                                  fontSize: 16
                                )),
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                        context.read<ClinicCubit>().getClinics(false, values.start, values.end, controller.text);
                        context.pop({
                          'min': values.start,
                          'max': values.end,
                          'city': controller.text
                        });
                    },
                    child: Container(
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff58a2eb)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: HTText(
                                label: 'search',
                                style: htBoldLabelStyle),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> turkishCities = [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Isparta',
    'Mersin',
    'İstanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      HTIcon(iconName: AssetConstants.icons.close, onPress: () {
        query = '';
      },)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return HTIcon(iconName: AssetConstants.icons.search, onPress: () {
      close(context, null);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var city in turkishCities) {
      if(city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
        itemBuilder: (context, index) {
      var result = matchQuery[index];
      return ListTile(
        title: HTText(label: result, style: htLabelBlackStyle,),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var city in turkishCities) {
      if(city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: HTText(label: result, style: htLabelBlackStyle,),
          );
        });
  }


}