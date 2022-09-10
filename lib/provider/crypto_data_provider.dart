import 'package:crypto_app/data/model/CryptoModel/all_crypto_model.dart';
import 'package:crypto_app/data/data_source/api_provider.dart';
import 'package:crypto_app/data/data_source/response_model.dart';
import 'package:flutter/cupertino.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFutrue;
  late ResponseModel state;
  var response;

  var defaultChoiceIndex = 0;

  getTopMarketCapData() async {
    defaultChoiceIndex = 0;
    state = ResponseModel.loading("loading...");
    notifyListeners();
    try {
      response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFutrue = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFutrue);
      } else {
        state = ResponseModel.error("somthing went wrong...");
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("Check your connection...");
    }
    notifyListeners();
  }

  getTopGainersCapData() async {
    defaultChoiceIndex=1;
    state = ResponseModel.loading("loading...");
    notifyListeners();
    try {
      response = await apiProvider.getTopGainerData();
      if (response.statusCode == 200) {
        dataFutrue = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFutrue);
      } else {
        state = ResponseModel.error("somthing went wrong...");
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("Check your connection...");
    }
    notifyListeners();
  }

  getTopLosersCapData() async {
    defaultChoiceIndex=2;
    state = ResponseModel.loading("loading...");
    notifyListeners();
    try {
      response = await apiProvider.getTopLosersData();
      if (response.statusCode == 200) {
        dataFutrue = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFutrue);
      } else {
        state = ResponseModel.error("somthing went wrong...");
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("Check your connection...");
    }
    notifyListeners();
  }
}
