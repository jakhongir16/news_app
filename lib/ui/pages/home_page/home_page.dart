import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:news_bloc/api/news_repository.dart';
import 'package:news_bloc/bloc/news_bloc.dart';
import 'package:news_bloc/provider/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsRepository = NewsRepository();
    return BlocProvider(
      create: (context) =>
          NewsBloc(newsRepository: newsRepository)..add(const NewsLoadEvent()),
      child: const ScaffoldWidget(),
    );
  }
}

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NewsProvider>(context);
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.deepPurpleAccent,
        width: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SafeArea(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  context.read<NewsBloc>().add(const NewLangUzEvent());
                },
                child: const Text(
                  'UZ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<NewsBloc>().add(const NewsLoadEvent());
                },
                child: const Text(
                  'RU',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<NewsBloc>().add(const NewLangEnEvent());
                },
                child: const Text(
                  'EN',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Uzreport'),
        centerTitle: true,
        actions: [
          CupertinoSwitch(
            thumbColor: Colors.deepPurple,
            activeColor: Colors.deepPurple[200],
            trackColor: Colors.deepPurple[100],
            value: model.isTheme,
            onChanged: (bool value) {
              model.changeTheme();
            },
          ),
        ],
      ),
      body: const BlocBody(),
    );
  }
}

class BlocBody extends StatelessWidget {
  const BlocBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: const [
        StateBlocWidget(),
      ],
    );
  }
}

class StateBlocWidget extends StatelessWidget {
  const StateBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is NewsLoadedState) {
        return Expanded(
          child: ListView.builder(
              itemCount: state.newsFeed?.items.length,
              itemBuilder: (context, index) {
                return ExpansionWidget(
                  state: state,
                  index: index,
                );
              }),
        );
      }
      return const Center(
        child: Text('Error'),
      );
    });
  }
}

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({Key? key, required this.state, required this.index})
      : super(key: key);
  final NewsLoadedState state;
  final int index;
  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final model = widget.state.newsFeed?.items[widget.index];
    return ExpansionTile(
      onExpansionChanged: (bool value) {
        setState(() {
          isActive = value;
        });
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model?.title}',
            style: const TextStyle(
                fontSize: 18,
                // color: Colors.grey[350],
                fontWeight: FontWeight.bold),
          ),
          Text(
            '${model?.pubDate}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[350],
            ),
          ),
        ],
      ),
      trailing: !isActive
          ? const Icon(Icons.arrow_drop_down)
          : const Icon(Icons.arrow_drop_up),
      children: [
        FullScreenWidget(
          disposeLevel: DisposeLevel.Low,
          child: Image.network(
            '${model?.enclosure?.url}',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text('${model?.description}'),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () async {
            final Uri url = Uri.parse('${model?.link}');
            try {
              await launchUrl(url);
            } catch (e) {
              throw 'Couldn\'t launch $url';
            }
          },
          child: Text(
            '${model?.link}',
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
