import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/models/source_entity.dart';
import 'package:projects/screens/home_screen/home_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'source_location_view_model.dart';

class SourceLocationsScreen extends StatelessWidget {
  const SourceLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SourceLocationsViewModel>(
      create: (_) => SourceLocationsViewModel(),
      child: SourceLocationsScreenBody(),
    );
  }
}

class SourceLocationsScreenBody extends StatelessWidget {
  const SourceLocationsScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SourceLocationsViewModel>(builder: (context, _model, _) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _model.controller,
                  decoration: InputDecoration(
                    hintText: "Example ( Cairo )",
                    suffixIcon: IconButton(
                      onPressed: _model.searchOnLocations,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  onChanged: _model.checkValue,
                ),
              ),
              _model.locations.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text("No Data available yet"),
                      ),
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: CustomFooter(
                          builder: (BuildContext context,LoadStatus? mode){
                            Widget body ;
                            if(mode==LoadStatus.idle){
                              body =  Text("pull up load");
                            }
                            else if(mode==LoadStatus.loading){
                              body =  CupertinoActivityIndicator();
                            }
                            else if(mode == LoadStatus.failed){
                              body = Text("Load Failed!Click retry!");
                            }
                            else if(mode == LoadStatus.canLoading){
                              body = Text("release to load more");
                            }
                            else{
                              body = Text("No more Data");
                            }
                            return Container(
                              height: 55.0,
                              child: Center(child:body),
                            );
                          },
                        ),
                        controller: _model.refreshController!,
                        onRefresh: _model.onRefresh,
                        onLoading: _model.onLoading,
                        child: ListView(
                          children: _model.locations
                              .map<Widget>((e) => _buildSourceItem(e,context))
                              .toList(),
                        ),
                      ),
                    ),

            ],
          ),
        ),
      );
    });
  }

  _buildSourceItem(SourceEntity source,BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Row(
        children: [
          Text(
            source.name!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              context.read<HomeScreenViewModel>().setMyLocation(source);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Select",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
