import 'package:flutter/material.dart';
import 'package:health_tourism/view/clinics/clinics.dart';

import '../../../core/app/appTheme.dart';


class ClinicRangeSelectionWidget extends StatefulWidget {
  final Function(String)? onChange;
  final bool? barrierDismissible;
  final List<String>? operationFilter;



  const ClinicRangeSelectionWidget(
      {Key? key,
        this.barrierDismissible,
        this.onChange,
        this.operationFilter})
      : super(key: key);

  @override
  _ClinicRangeSelectionWidgetState createState() =>
      _ClinicRangeSelectionWidgetState();
}

class _ClinicRangeSelectionWidgetState extends State<ClinicRangeSelectionWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  DateTime? startDate;
  DateTime? endDate;

  List<String> texts = ['Hair', 'Skin', 'Nails'];
  late List<String> selectedOperations=[];



  void handleSelectedNumber(int? selectedNumber) {
    if (selectedNumber != null) {
      // Perform any operations based on the selected number
      print('Selected number: $selectedNumber');
      // Update the state or perform any other actions based on the selected number
    } else {
      // Handle the case when no number is selected
      print('No number selected');
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animationController.forward();
    selectedOperations = widget.operationFilter ?? [];
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: animationController.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible!) {
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.getTheme().colorScheme.background,
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.getTheme().dividerColor,
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            getRowView(
                                "Adult",
                                0,
                                onSelectNumber: handleSelectedNumber),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 24),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppTheme.getTheme().primaryColor,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: AppTheme.getTheme().dividerColor,
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      try {
                                        for(var opr in selectedOperations){
                                          widget.onChange!(opr);
                                        }
                                        Navigator.pop(context);
                                      } catch (e) {}
                                    },
                                    child: const Center(
                                      child: Text(
                                        "S.of(context).apply",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getRowView(
      String txt,
      int? count,
      {List<String>? numberList,
        required void Function(int?) onSelectNumber}
      ) {
    numberList ??= ["LL", "KK"];
    int size = texts.length;
// Default number list if not provided

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: size,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    String itemText = texts[index];
                                    bool isSelected = selectedOperations.contains(itemText);

                                    return ListTile(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            for (var oper in selectedOperations) {
                                              print(oper);
                                            }
                                            selectedOperations.remove(itemText);
                                          } else {
                                            selectedOperations.add(itemText);
                                            print("ADD"+itemText);
                                          }
                                        });
                                      },
                                      title: Text(itemText),
                                      // Add a checkbox or indicator to show selection
                                      leading: isSelected ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
                                    );
                                  },
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }


}

