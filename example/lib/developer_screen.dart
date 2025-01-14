import 'package:flutter/material.dart';
import 'example.dart';

class DeveloperScreen extends StatelessWidget {
  final List<Example> mapExamples;

  const DeveloperScreen({Key? key, required this.mapExamples}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Options'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Map Examples',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: mapExamples.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, int index) {
                final example = mapExamples[index];
                return ListTile(
                  leading: example.leading,
                  title: Text(example.title),
                  subtitle: (example.subtitle?.isNotEmpty == true)
                      ? Text(
                          example.subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => Scaffold(
                          appBar: AppBar(title: Text(example.title)),
                          body: example,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 