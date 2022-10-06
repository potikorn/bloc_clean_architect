import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_clean_architect/src/core/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_clean_architect/src/features/counter/presentation/counter_page.dart';
import 'package:bloc_clean_architect/src/features/login/view/login_page.dart';
import 'package:bloc_clean_architect/src/features/post/presentation/view/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful')),
          );
        }
      },
      builder: (context, state) {
        final isLoggedIn = state.status == AuthenticationStatus.authenticated;
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Bloc'),
                actions: [
                  IconButton(
                    onPressed: () => isLoggedIn
                        ? context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested())
                        : Navigator.push(context, LoginPage.route()),
                    icon: Icon(isLoggedIn ? Icons.logout : Icons.login),
                  )
                ],
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(isScrollable: true, tabs: [
                      Tab(
                        text: 'Counter',
                      ),
                      Tab(
                        text: 'Posts',
                      )
                    ]),
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
      },
    );
  }
}
