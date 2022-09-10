import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/data/data_source/response_model.dart';
import 'package:crypto_app/provider/crypto_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/model/CryptoModel/crypto_data.dart';
import '../../helper/decimal_rounder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  var cryptoPrice;
  final List<String> _choicesIndex = ['Top Market', 'Top Gain', 'Top Loss'];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final cryptoProvider = Provider.of<CryptoDataProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey[900],
              child: Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: 0,
                          top: MediaQuery.of(context).size.height * .02),
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Marquee(
                            text:
                                "Bitcoin \$$cryptoPrice, /  Etherum \$8,162 /  ",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25)),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .2,
                        bottom: 20),
                    child: Consumer<CryptoDataProvider>(
                      builder: (context, cryptoDataProvider, child) {
                        switch (cryptoDataProvider.state.status) {
                          case Status.LOADING:
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[400]!,
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .03,
                                            bottom: 8,
                                            left: 8),
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: SizedBox(
                                          width: 70,
                                          height: 40,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );

                          case Status.COMPLETED:
                            List<CryptoData>? model = cryptoDataProvider
                                .dataFutrue.data!.cryptoCurrencyList;

                            return ListView.separated(
                                itemBuilder: (context, index) {
                                  var number = index + 1;
                                  var tokenId = model![index].id;

                                  MaterialColor filterColor =
                                      DecimalRounder.setColorFilter(model[index]
                                          .quotes![0]
                                          .percentChange24h);

                                  var finalPrice =
                                      DecimalRounder.removePriceDecimals(
                                          model[index].quotes![0].price);
                                  cryptoPrice =
                                      DecimalRounder.removePriceDecimals(
                                          model[0].quotes![0].price);
                                  // percent change setup decimals and colors
                                  var percentChange =
                                      DecimalRounder.removePercentDecimals(
                                          model[index]
                                              .quotes![0]
                                              .percentChange24h);

                                  Color percentColor =
                                      DecimalRounder.setPercentChangesColor(
                                          model[index]
                                              .quotes![0]
                                              .percentChange24h);
                                  Icon percentIcon =
                                      DecimalRounder.setPercentChangesIcon(
                                          model[index]
                                              .quotes![0]
                                              .percentChange24h);

                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        )),
                                    height: height * 0.085,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            number.toString(),
                                            style: GoogleFonts.raleway(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15),
                                          child: CachedNetworkImage(
                                              fadeInDuration: const Duration(
                                                  milliseconds: 500),
                                              fadeInCurve: Curves.linear,
                                              height: 32,
                                              width: 32,
                                              imageUrl:
                                                  "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) {
                                                return const Icon(Icons.error);
                                              }),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model[index].name!,
                                                style: GoogleFonts.raleway(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                model[index].symbol!,
                                                style: GoogleFonts.raleway(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: ColorFiltered(
                                              colorFilter: ColorFilter.mode(
                                                  filterColor,
                                                  BlendMode.srcATop),
                                              child: SvgPicture.network(
                                                  "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "\$$finalPrice",
                                                  style: GoogleFonts.jaldi(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    percentIcon,
                                                    Text(
                                                      "$percentChange%",
                                                      style: GoogleFonts.ubuntu(
                                                          color: percentColor,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: 11);
                          case Status.ERROR:
                            return Text(cryptoDataProvider.state.message);
                          default:
                            return Container();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .13),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<CryptoDataProvider>(
                            builder: (context, CryptoDataProvider, child) {
                              return Wrap(
                                spacing: 8,
                                children: List.generate(_choicesIndex.length,
                                    (index) {
                                  return ChoiceChip(
                                    elevation: 10,
                                    label: Text(_choicesIndex[index]),
                                    selected:
                                        CryptoDataProvider.defaultChoiceIndex ==
                                            index,
                                    selectedColor: Colors.amber[300],
                                    onSelected: (value) {
                                      CryptoDataProvider.defaultChoiceIndex =
                                          value
                                              ? index
                                              : CryptoDataProvider
                                                  .defaultChoiceIndex;
                                      switch (index) {
                                        case 0:
                                          cryptoProvider.getTopMarketCapData();
                                          break;
                                        case 1:
                                          cryptoProvider.getTopGainersCapData();
                                          break;
                                        case 2:
                                          cryptoProvider.getTopLosersCapData();
                                          break;
                                      }
                                    },
                                  );
                                }),
                              );
                            },
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
