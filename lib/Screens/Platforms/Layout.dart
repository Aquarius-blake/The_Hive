import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Ads/ad_helper.dart';
import 'package:forum3/Provider/Settings_provider.dart';
import 'package:forum3/Screens/Home/home.dart';
import 'package:forum3/Screens/Platforms/Web.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';

//Seperates the view for android and web based on screen size.
class Layout extends StatefulWidget {


  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
 
 late bool exit;

 
  // TODO: Add _interstitialAd
 InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              exit=true;
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
 
  Future<bool> _onexit() async{
    // Since this is an async method, anything you do here will not block UI thread
    // So you should inform user there is a work need to do before exit, I recommend SnackBar

    // Do your pre-exit works here...

    // also, you must decide whether the app should exit or not after the work above, by returning a future boolean value:
     _loadInterstitialAd();
     Future.delayed(Duration(seconds: 2),(){
       if (_interstitialAd != null) {
         _interstitialAd!.show();
       } else {
         print('Interstitial ad is still loading...');
       }
     });
    return Future<bool>.value(exit); 
 
  }
 
  @override
  void initState() {
    initial();
    super.initState();
  }


  void initial()async{
    /* DocumentSnapshot snap= await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username=(snap.data() as Map<String,dynamic>)['username'];
    });*/

    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.Refreshuser();

    //Theme provider(in progress)
    ThemeProvider _themeProvider=Provider.of(context,listen: false);
    await _themeProvider.RefreshTheme();
    

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onexit ,
      child: LayoutBuilder(
          builder: (context, constraints) {
            if(kIsWeb){
              return Webview();
            }else{
              return Home();
            }
          }
          ),
    );

  }
}
