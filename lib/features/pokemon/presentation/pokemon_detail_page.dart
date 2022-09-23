import 'package:flutter/material.dart';

class PokemonDetailPage extends StatelessWidget {
  static const String routeName = '/pokemon_detail';

  const PokemonDetailPage({Key? key, required this.arguments})
      : super(key: key);

  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // cover image with Hero animation
            Hero(
              tag: arguments['id'],
              child: Image.network(
                arguments['imageUrl'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
            // pokemon name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        arguments['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '#${arguments['id']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // description
                  Text(
                    arguments['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                  ),
                  // category
                  const SizedBox(height: 8),
                  Text(
                    "Category: ${arguments['category']}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // weight and height section
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${arguments['weight']} kg',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Height',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${arguments['height']} m',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // typeofpokemon
                  Text(
                    "Type of Pokemon",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: arguments['typeofpokemon']
                        .map<Widget>(
                          (type) => Chip(
                            label: Text(type),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Weaknesses',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: arguments['weaknesses']
                        .map<Widget>(
                          (type) => Chip(
                            label: Text(type),
                          ),
                        )
                        .toList(),
                  ),
                  //speed
                  const SizedBox(height: 16),
                  // data table for speed, attack, defense and hp
                  Text(
                    'Stats',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DataTable(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    columns: const [
                      DataColumn(label: Text("Speed")),
                      DataColumn(label: Text("Attack")),
                      DataColumn(label: Text("Defense")),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(arguments['speed'])),
                        DataCell(Text(arguments['attack'])),
                        DataCell(Text(arguments['defense'])),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
