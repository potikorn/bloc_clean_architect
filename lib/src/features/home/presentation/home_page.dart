import 'package:bloc_clean_architect/src/features/counter/presentation/counter_page.dart';
import 'package:bloc_clean_architect/src/features/post/presentation/view/post_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, kToolbarHeight),
            child: Container(
              color: Theme.of(context).primaryColor,
              child: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'Counter',
                  ),
                  Tab(
                    text: 'Posts',
                  )
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              CounterPage(),
              PostPage(),
            ],
          ),
        ),
      ),
    );
  }
}
