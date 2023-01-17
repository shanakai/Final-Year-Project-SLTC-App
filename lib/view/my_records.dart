import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vis_mobile/service/RecordsModes.dart';
import 'package:vis_mobile/view/home_ui.dart';
import '../payment/controllers/payment_controller.dart';
import '../service/fetchRecords.dart';
import 'common/drawer.dart';

class MyRecordsScreen extends StatefulWidget {
  const MyRecordsScreen({super.key});

  @override
  State<MyRecordsScreen> createState() => _MyRecordsScreenState();
}

class _MyRecordsScreenState extends State<MyRecordsScreen> {
  String price = '0';
   FetchOwnRecords _recordtList =  FetchOwnRecords ();

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade600,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'My Records',
            ),
            backgroundColor: const Color.fromARGB(255, 29, 112, 238),
          ),
          drawer: const DrawerComponent(),
          body: FutureBuilder<List<Record>>(
              future: _recordtList.getRecordList(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "FROM",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: Colors.indigo.shade50,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: SizedBox(
                                          height: 20,
                                          width: 8,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.indigo.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 24,
                                                child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    return Flex(
                                                      // ignore: sort_child_properties_last
                                                      children: List.generate(
                                                          (constraints.constrainWidth() /
                                                                  6)
                                                              .floor(),
                                                          (index) => SizedBox(
                                                                height: 1,
                                                                width: 3,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300),
                                                                ),
                                                              )),
                                                      direction:
                                                          Axis.horizontal,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Center(
                                                  child: Transform.rotate(
                                                angle: 0,
                                                child: Icon(
                                                  Icons.car_crash_rounded,
                                                  color: Colors.indigo.shade300,
                                                  size: 24,
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: Colors.pink.shade50,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: SizedBox(
                                          height: 8,
                                          width: 8,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 153, 0, 241),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      const Text(
                                        "TO",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 7, 7)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            '${data?[index].checkin}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          )),
                                      const Text(
                                        "to",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            '${data?[index].checkout}',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${data?[index].inDateTime}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${data?[index].outDateTime}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${data?[index].vehiclenumber}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            '${data?[index].paymentStatus}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Flex(
                                            direction: Axis.horizontal,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                        10)
                                                    .floor(),
                                                (index) => SizedBox(
                                                      height: 1,
                                                      width: 5,
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400),
                                                      ),
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.amber.shade50,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Icon(Icons.car_rental,
                                        color: Colors.blue),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text('LKR: ${data?[index].price}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey)),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();

                                    price = data?[index].price ?? '';
                                        await prefs.setString(
                                            'recordId',
                                            (data?[index].id)
                                                .toString());
                                        await prefs.setString(
                                            'price',
                                            (data?[index].price)
                                                .toString());
                                        // ignore: use_build_context_synchronously
                              controller.makePayment(amount: data?[index].price ?? '' , currency: 'USD');
                            
                                      },
                                      
                                      child:  const Text(
                                        'Make Payment',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black, backgroundColor: Color.fromARGB(255, 230, 174, 6)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }),
        ),
    );
  }
}
