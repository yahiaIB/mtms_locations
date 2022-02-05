import 'package:flutter/material.dart';
import 'package:projects/models/source_entity.dart';
import 'package:projects/repository/destination_repository.dart';
import 'package:projects/utilts/helper_functions.dart';
import 'package:projects/viewModels/base_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DestinationLocationsViewModel extends BaseViewModel {
  TextEditingController? controller;
  List<SourceEntity> locations = [];
  RefreshController? refreshController;
  DestinationRepository? _repository;
  int _page = 0;
  bool reachedLast = false;

  DestinationLocationsViewModel() {
    controller = TextEditingController();
    refreshController = RefreshController(initialRefresh: false);
    _repository = DestinationRepository();
  }

  searchOnLocations() async {
    try {
      if (controller!.text.trim().isEmpty) {
        HelperFunctions.toast(text: "You must type something first..");
      }
      if(reachedLast) return;
      if(_page == 0) setBusy(true);
      List<SourceEntity> _locations = await _repository!.getCities(search: controller!.text.trim(), page: _page);
      if(_locations.isEmpty) {
        refreshController!.loadNoData();
        reachedLast = true;
        return;
      }
      if(_page == 0) {
        locations = _locations;
        setBusy(false);
      }
      else locations.addAll(_locations);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  checkValue(String value){
    _page = 0;
    reachedLast = false;
    locations = [];
    notifyListeners();
  }

  void onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 400));
    // if failed,use refreshFailed()
    _page = 0;
    reachedLast = false;
    await searchOnLocations();
    refreshController!.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 400));
    _page ++;
    await searchOnLocations();
    refreshController!.loadComplete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController!.dispose();
    controller!.dispose();
  }
}
