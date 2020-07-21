import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AppBar2.dart';
import 'package:flutter_payphone/flutter_payphone.dart';
const API_KEY_PAYPHONE = "v7QDtzjoWQ5vUJ382H1qQYEMW-P1RhivmhvUGChQ4JnF3Ab9kf3E9GUvnwFMwmCaa7xZqVZZv5ui-zDqdRrGF73NjJmiHXc6qiiuVRcv6zD5W93zAbXdGLyixN7zB7wxFE9W1hodLkDIan8mzs5bLHelTfFb9li7dSit0c39l0X8XbrgPpD0UYjFS1D8H261hypHXXGNbYY-OugcWrhBUxV1Ft4Inq0XCaosk1bHe5gYU4y6jpQFljfLskpzsOHMXuECuH6XeKtSqkRUpJm8N4Iv7Xq6yf7ul_IhbYJut674qUg5ApTUXGJpJPNw3RjU_JvxRw";

/*
import 'package:flutter_culqi/src/card.dart';
import 'package:flutter_culqi/src/internationalization/translation.dart';
import 'package:flutter_culqi/flutter_culqi.dart';

/// You need to paste your Culqi public key here
final String _publicKey = 'INSERT_YOUR_PUBLIC_KEY_HERE';

class Paso4 extends StatelessWidget {
  /// This functions tests the creation of a [CulqiToken] given a [CulqiCard]
  void onlyApi() async {
    CulqiCard card = CulqiCard(
        cardNumber: '4111111111111111',
        cvv: '123',
        expirationMonth: 9,
        expirationYear: 2020,
        email: 'test@testmail.com');

    CulqiTokenizer tokenizer = CulqiTokenizer(card);

    var result = await tokenizer.getToken(publicKey: _publicKey);
    if (result is CulqiToken) {
      print(result.token);
    } else if (result is CulqiError) {
      print(result);
    }
  }

  MyApp() {
    onlyApi();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culqi Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final heard2 = Heard2('images/pagar.jpg', 'Metodo de Pago', '4', 0.8);
  GlobalKey<CulqiPaymentState> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _token = '';


  List<String> _months;
  List<int> _years;

  String _cardNumber;
  String _cvv;
  int _selectedMonth = 0;
  int _selectedYear = 0;


*/
/*
  @override
  void initState() {
    _months = Translations.months(widget.locale);
    _years = widget.years;
    super.initState();
  }
*//*



  List<Widget> _buildMonths() {
    return _months.map((val) => Text(val)).toList();
  }

  List<Widget> _buildYears() {
    return _years.map((val) => Text(val.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: myAppBar2(),
            backgroundColor: Colors.black,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar2(
                heard2: heard2,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          title: Text('numero tarjera',
                            style: TextStyle(fontSize: 12),
                          ),
                          subtitle: TextFormField(
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 15),
                                hintText: "XXXX - XXXX - XXXX - XXXX"),
                            onFieldSubmitted: (value) {},

*/
/*validator: (value) {
                              if (value.isEmpty) return Translations.emptyWarningLabel(widget.locale);
                              _cardNumber = value;
                              return null;
                            },*//*


                          )),
                      Container(
                        height: 10,
                      ),
                      ListTile(
                        title: Text('Mes',
                          style: TextStyle(fontSize: 12),
                        ),
                        subtitle: GestureDetector(
                          child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text('nada'),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              )),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                    child: CupertinoPicker(
                                      itemExtent: 35.0,
                                      onSelectedItemChanged:
                                          (value) {
                                        setState(() {
                                          _selectedMonth = value;
                                        });
                                      },
                                      children: _buildMonths(),
                                      looping: true,
                                      backgroundColor:
                                      Colors.white,
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text('años')),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return Container(
                                  child: CupertinoPicker(
                                    itemExtent: 35.0,
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedYear = value;
                                      });
                                    },
                                    children: _buildYears(),
                                    looping: true,
                                    backgroundColor: Colors.white,
                                  ),
                                );
                              });
                        },
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "XXX",
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (value) {},

*/
/*validator: (value) {
                          if (value.isEmpty) return Translations.emptyWarningLabel(widget.locale);
                          _cvv = value;
                          return null;
                        },*//*


                      ), //

                    ],
                  ),
                ),
            /// This is a provided widget to make faster the Culqi integration. Is not mandatory to use it,
            /// you can create your own form to get the necessary fields to get a token.
            ///
            /// Of course, the creation of the token requires an email, but on the most cases, the email
            /// is the login method, so the app already has the user email. Because of that the
            /// [CulqiPayment] widget wont request the email, and you need to provide it to the [CulqiCard]
            CulqiPayment(_key, locale: 'es', years: [2020, 2021, 2022, 2023, 2024],
            ),

            /// In this example, here we are requesting the email and save it on [_email].
            Container(
              padding: EdgeInsets.all(10),
              height: 70,
              child: TextField(
                onChanged: (value){
                  _email = value;
                },
                decoration: new InputDecoration(
                    errorStyle: TextStyle(fontSize: 10),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue[900],
                      size: 15,
                    ),
                    labelText: 'Email:',
                    hintText: 'test@test.com'

                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: getToken,
                child: Text(
                  'CONFIRMAR COMPRA',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightGreen,
              ),
            ),
            Text(_token)
          ]))
        ],
      ),
    );
  }

  /// This async function allows us to get the info from the [CulqiPayment] widget and check if all the fields
  /// were completed. If it happens, set the [_email] on the [_card].
  ///
  /// Finally, using the [CulqiTokenizer] we try to get the token.
  void getToken() async {
    CulqiCard _card = CulqiCard();
    bool success = _key.currentState.setInfoOn(_card);

    if (success) {
      _card.email = _email;

      CulqiTokenizer _tokenizer = CulqiTokenizer(_card);

      var result = await _tokenizer.getToken(publicKey: _publicKey);
      if (result is CulqiToken) {
        setState(() {
          _token = result.token;
        });
      } else if (result is CulqiError) {
        setState(() {
          _token = result.errorMessage;
        });
      }
    }
  }
}



*/






class Paso5 extends StatelessWidget {

  final heard2 = Heard2('images/pagar.jpg', 'Metodo de Pago', '5', 0.9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: myAppBar2(),
            backgroundColor: Colors.black,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar2(
                heard2: heard2,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                  child: Column(
                      children: <Widget>[
                        Text('Pago por PAYPHONE'),
                        RaisedButton(
                            child: Text(
                              'Solicitar Pago',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.orange,
                            onPressed: () async {
                              var resultado = await Payphone(API_KEY_PAYPHONE)
                                  .enviarVentaResultadoWidget(
                                  context,
                                  CircularProgressIndicator(),
                                  "0992788894",
                                  112,
                                  100,
                                  12,
                                  "u8q2RegjrE6IX7YUXwlVQ",
                                  "Pack Manos");
                              print("RESULTADO EN TEST: " + resultado.toString());
                            }),
                        Text('Pago por PAYPAL'),
                      ],
                    ),
                  ),

              ]))
        ],
      ),
    );
  }
}


/*
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Culqi Example'),
      ),
      body: ListView(

        children: <Widget>[

          /// This is a provided widget to make faster the Culqi integration. Is not mandatory to use it,
          /// you can create your own form to get the necessary fields to get a token.
          ///
          /// Of course, the creation of the token requires an email, but on the most cases, the email
          /// is the login method, so the app already has the user email. Because of that the
          /// [CulqiPayment] widget wont request the email, and you need to provide it to the [CulqiCard]
          CulqiPayment(_key, locale: 'en', years: [2020, 2021, 2022, 2023, 2024],),

          /// In this example, here we are requesting the email and save it on [_email].
          ListTile(
            title: Text('Email', style: TextStyle(fontSize: 12),),
            subtitle: TextField(
              onChanged: (value){
                _email = value;
              },
              decoration: InputDecoration(
                  hintText: 'test@test.com'
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: getToken,
              child: Text('Get Token', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
            ),
          ),
          Text(_token)
        ],
      ),
    );
  }
*/