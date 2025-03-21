import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/refresh_controller.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      home: const RefreshView(),
    );
  }
}

class RefreshView extends GetView<RefreshController> {
  const RefreshView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RefreshIndicator Sample')),
      body: RefreshIndicator(
        color: const Color.fromARGB(255, 86, 86, 86),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        onRefresh: () async {
          // Simulasi proses refresh
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        // notificationPredicate: (ScrollNotification notification) {
        //   return notification.depth == 1;
        // },
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 0 || notification.depth == 1;
        },
        

        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                alignment: Alignment.center,
                color: Colors.pink[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Pull down here',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text("RefreshIndicator won't trigger"),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.green[100],
                height: 300,
                child: ListView.builder(
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return const ListTile(
                      title: Text('Pull down here'),
                      subtitle: Text('RefreshIndicator will trigger'),
                    );
                  },
                ),
              ),
            ),
            SliverList.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  title: Text('Pull down here'),
                  subtitle: Text("Refresh indicator won't trigger"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
