import 'package:flutter/widgets.dart';

import '../data/model/CryptoModel/all_crypto_model.dart';
import '../data/data_source/api_provider.dart';
import '../data/data_source/response_model.dart';

class MarketViewProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;

  late ResponseModel state;
  var response;

  getCryptoData() async {
    // start loading api
    state = ResponseModel.loading("is loading...");
    // notifyListeners();

    try {
      response = await apiProvider.getAllCryptoData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something wrong please try again...");
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("please check your connection...");
      notifyListeners();

      print(e.toString());
    }
  }
}
