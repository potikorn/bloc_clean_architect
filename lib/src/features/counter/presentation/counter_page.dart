import 'package:bloc_clean_architect/src/di/inject.dart';
import 'package:bloc_clean_architect/src/features/counter/domain/use_cases/counter/restore.dart';
import 'package:bloc_clean_architect/src/features/counter/domain/use_cases/counter/save_to_disk.dart';
import 'package:bloc_clean_architect/src/features/counter/presentation/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(
        getIt<SaveToDiskUseCase>(),
        getIt<RestoreUseCase>(),
      ),
      child: const _BodyCounterPage(),
    );
  }
}

class _BodyCounterPage extends StatefulWidget {
  const _BodyCounterPage();

  @override
  State<_BodyCounterPage> createState() => _BodyCounterPageState();
}

class _BodyCounterPageState extends State<_BodyCounterPage>
    with AutomaticKeepAliveClientMixin<_BodyCounterPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<CounterCubit, int>(
        builder: ((context, state) {
          return Center(
            child: (Text('State: $state')),
          );
        }),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: const Key('increase'),
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            heroTag: const Key('decrease'),
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            heroTag: const Key('save'),
            onPressed: () => context.read<CounterCubit>().saveToDisk(),
            child: const Icon(Icons.save),
          )
        ],
      ),
    );
  }
}
