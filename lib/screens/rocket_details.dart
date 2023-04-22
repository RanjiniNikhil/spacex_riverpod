import 'package:flutter/material.dart';
import 'package:spacex_riverpod/models/rocket_response_model.dart';
import 'package:spacex_riverpod/stringConstants.dart';
import 'package:spacex_riverpod/widgets/rockets_widget.dart';

class RocketDetailsPage extends StatelessWidget {
  const RocketDetailsPage({Key? key, required this.rocketResponseModel})
      : super(key: key);
  final RocketResponseModel rocketResponseModel;

  Widget view(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: [
          Text(
            rocketResponseModel.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          flickerImage(
              height: 180,
              width: 160,
              flickerImages: rocketResponseModel.flickrImages,
              margin: EdgeInsets.only(right: 10, top: 20, bottom: 20)),
          details(StringConstant.activeStatus,
              rocketResponseModel.active.toString()),
          details(StringConstant.costPerlaunch,
              rocketResponseModel.costPerLaunch.toString()),
          details(StringConstant.successRatePercentage,
              rocketResponseModel.successRatePct.toString()),
          details(StringConstant.description, rocketResponseModel.description),
          details(StringConstant.wikipedia, rocketResponseModel.wikipedia),
          diameterWidget(
              StringConstant.height,
              rocketResponseModel.height.meters,
              rocketResponseModel.height.feet),
          diameterWidget(
              StringConstant.diameter,
              rocketResponseModel.diameter.meters,
              rocketResponseModel.diameter.feet)
        ],
      ),
    );
  }

  Widget details(String type, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Text(type + value),
    );
  }

  Widget diameterWidget(String type, double meters, double feet) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Text(type +
          ":  " +
          StringConstant.meter +
          meters.toString() +
          StringConstant.feet +
          feet.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(StringConstant.rocketDetails),
        backgroundColor: Colors.indigo,
      ),
      body: view(context),
    );
  }
}
