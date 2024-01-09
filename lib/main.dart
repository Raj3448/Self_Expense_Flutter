//import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:myfirstapp/widget/chart.dart';
import 'package:myfirstapp/widget/newTransaction.dart';
import './model/Transaction.dart';
import './widget/transactionList.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MyHomePage(),
      title: 'Personal Expenses',
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final List<Transaction> usertranscation = [
    // Transaction(
    //     id: 'T1', title: 'New Mobile', amount: 12999, date: DateTime.now()),
    // Transaction(
    //     id: 'T2', title: 'New Car', amount: 816999, date: DateTime.now()),
  ];

  void addTransaction(String Title, double money, DateTime selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: Title,
        amount: money,
        date: selectedDate);
    setState(() {
      usertranscation.add(newTx);
    });
  }

  List<Transaction> get _recentTransaction {
    return usertranscation.where((Tx) {
      return Tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void StartAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(addNewTx: addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      usertranscation.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  bool _showchart = true;
  List<Widget> _renderLanscapeContent(
      MediaQueryData _Media_query, AppBar appBar, final TxList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show chart'),
          Switch.adaptive(
              //adoptive give look and feel on ios platform
              activeColor: Colors.pink,
              activeTrackColor: Color.fromARGB(255, 245, 109, 154),
              value: _showchart,
              onChanged: (val) {
                setState(() {
                  _showchart = val;
                });
              }),
        ],
      ),
      _showchart
          ? Container(
              height: (_Media_query.size.height -
                      appBar.preferredSize.height -
                      _Media_query.padding.top) *
                  0.7,
              width: double.infinity,
              child: Chart(_recentTransaction),
            )
          : TxList,
    ];
  }

  List<Widget> _renderPortraitContent(
      MediaQueryData _Media_query, AppBar appBar, final TxList) {
    return [
      Container(
        height: (_Media_query.size.height -
                appBar.preferredSize.height -
                _Media_query.padding.top) *
            0.3,
        width: double.infinity,
        child: Chart(_recentTransaction),
      ),
      TxList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _Media_query = MediaQuery.of(context);
    final isLandScape = _Media_query.orientation == Orientation.landscape;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Self Expenses'),
            trailing: GestureDetector(child: Icon(CupertinoIcons.add)),
          )
        : AppBar(
            backgroundColor: Colors.pink,
            title: Text('Self Expenses'),
            actions: [
              IconButton(
                  onPressed: () => StartAddNewTransaction(context),
                  icon: Icon(Icons.add_outlined)),
            ],
          );
    final TxList = Container(
        height: (_Media_query.size.height -
                appBar.preferredSize.height -
                _Media_query.padding.top) *
            0.7,
        child: TransactionList(usertranscation, deleteTransaction));

    final _pagebody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              ..._renderLanscapeContent(_Media_query, appBar, TxList),

            if (!isLandScape)
              ..._renderPortraitContent(_Media_query, appBar, TxList),
            //widget variable assign above user defined
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(navigationBar: appBar, child: _pagebody)
        : Scaffold(
            appBar: appBar,
            body: _pagebody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    // checking platform here to give button or not on different platform
                    onPressed: () => StartAddNewTransaction(context),
                    child: const Icon(Icons.add_circle),
                    backgroundColor: Colors.purple,
                  ),
          );
  }
}
