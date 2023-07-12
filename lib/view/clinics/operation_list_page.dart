import 'package:flutter/material.dart';
import 'package:health_tourism/core/app/appTheme.dart';
import 'package:health_tourism/product/models/clinics-entity.dart';
import 'package:health_tourism/view/clinics/widgets/operation_list_row_widget.dart';


class OperationListPage extends StatefulWidget {
  final String? clinicName;

  const OperationListPage({Key? key, this.clinicName}) : super(key: key);

  @override
  _OperationListPageState createState() => _OperationListPageState();
}

class _OperationListPageState extends State<OperationListPage>
    with TickerProviderStateMixin {
  List<ClinicEntity> romeList = ClinicEntity.clinicList;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: Column(
        children: <Widget>[
          getAppBarUI(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: romeList.length,
              itemBuilder: (context, index) {
                var count = romeList.length > 10 ? 10 : romeList.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController!,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController!.forward();
                return OperationListRowWidget(
                  operationData: romeList[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.getTheme().dividerColor,
              offset: Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.clinicName!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.favorite_border),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}