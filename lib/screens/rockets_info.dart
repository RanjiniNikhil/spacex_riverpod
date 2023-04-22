import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_riverpod/data_provider/rocket_data_provider.dart';
import 'package:spacex_riverpod/data_provider/rocket_db_provider.dart';
import 'package:spacex_riverpod/models/rocket_response_model.dart';
import 'package:spacex_riverpod/screens/rocket_details.dart';
import 'package:spacex_riverpod/stringConstants.dart';
import 'package:spacex_riverpod/widgets/rockets_widget.dart';

class RocketsInfoPage extends ConsumerWidget {
  const RocketsInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(rocketDataProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringConstant.rockets),
        backgroundColor: Colors.indigo,
      ),
      body: data.when(
          data: (data) {
            List<RocketResponseModel> rocketsList = data.map((e) => e).toList();
            RocketDBProvider.deleteAllRockets();
            (rocketsList as List).map((rocket) {
              RocketDBProvider.addRocket(rocket);
            }).toList();
            return ListView.separated(
              itemCount: rocketsList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    // Sending the data from listing screen to detail screen
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => RocketDetailsPage(
                    //         rocketResponseModel: rocketsList[index])));

                    // Fetching data stored in LocalDB SQFlite and send the data to detail screen
                    RocketResponseModel res =
                        await RocketDBProvider.getRocketDetails(
                            rocketsList[index].id);
                    print("${res.id}, ${res.name}");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RocketDetailsPage(rocketResponseModel: res)));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstant.name + rocketsList[index].name),
                        Text(StringConstant.country +
                            rocketsList[index].country),
                        Text(StringConstant.enginesCount +
                            rocketsList[index].engines.number.toString()),
                        flickerImage(
                            height: 100,
                            width: 100,
                            flickerImages: rocketsList[index].flickrImages,
                            margin: EdgeInsets.only(right: 10, top: 10)),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(thickness: 1.0, color: Colors.grey.shade400),
            );
          },
          error: (err, s) =>
              Center(child: Text(StringConstant.kSomethingWentWrong)),
          loading: () => Center(child: CircularProgressIndicator())),
    );
  }
}
