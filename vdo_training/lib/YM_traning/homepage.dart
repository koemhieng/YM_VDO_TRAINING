import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> imageGroups = [
    {
      'title': 'Group 1 - Horizontal',
      'isHorizontal': true,
      'images': [
        {
          'url': 'asset/image3.png', // Replace with your asset path
          'label': 'Image 1',
        },
        {
          'url': 'asset/image4.png', // Replace with your asset path
          'label': 'Image 2',
        },
      ],
    },
    {
      'title': 'Group 2 - Vertical',
      'isHorizontal': false,
      'images': [
        {
          'url': 'asset/image5.png', // Replace with your asset path
          'label': 'Image 3',
        },
        {
          'url': 'asset/image6.png', // Replace with your asset path
          'label': 'Image 4',
        },
      ],
    },
  ];

  final Map<String, List<Map<String, dynamic>>> videoGroups = {
    "INTRODUCTION": [
      {
        'url': 'https://www.youtube.com/watch?v=cmmi9LgXOMw',
        'title': 'Introduction 1',
        'views': 1500,
        'isFavorite': true,
      },
      {
        'url': 'https://www.youtube.com/watch?v=eegl7of4g-o',
        'title': 'Introduction 2',
        'views': 2500,
      },
    ],
    "RISE": [
      {
        'url': 'https://www.youtube.com/watch?v=VS0tQS1mnWI',
        'title': 'Rise 1',
        'views': 3200,
        'isFavorite': true,
      },
      {
        'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        'title': 'Rise 2',
        'views': 4500,
      },
    ],
    "C-TPAT": [
      {
        'url': 'https://www.youtube.com/watch?v=9bZkp7q19f0',
        'title': 'C-TPAT 1',
        'views': 5100,
      },
      {
        'url': 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ',
        'title': 'C-TPAT 2',
        'views': 6200,
      },
    ],
  };

  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'ទំព័រដើម',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.search),
            label: 'វគ្គសិក្សា',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.category),
            label: 'ប្រភេទ',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.picture_in_picture),
            label: 'រូបភាព',
          ),
        ],
        onTap: _onNavigationTap,
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 255, 68),
        title: Text(
          'វគ្គបណ្តុះបណ្តាលកម្មករចូលថ្មី',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 20, 19, 12),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          // First Page - Display Image Groups
          ListView.builder(
            itemCount: imageGroups.length,
            itemBuilder: (context, groupIndex) {
              final group = imageGroups[groupIndex];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group['title'],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    group['isHorizontal']
                        ? SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: group['images'].length,
                              itemBuilder: (context, index) {
                                final image = group['images'][index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(image['url']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        image['label'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Column(
                            children: group['images'].map<Widget>((image) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(image['url']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      image['label'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                  ],
                ),
              );
            },
          ),

          // Second Page - Display Video Groups
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: videoGroups.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: entry.value.map((video) {
                            final videoId = Uri.parse(video['url']!).queryParameters['v']!;
                            final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

                            return Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Handle thumbnail tap if needed
                                    },
                                    child: Image.network(
                                      thumbnailUrl,
                                      width: 250,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    video['title']!,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          // Third Page - Placeholder for Additional Dynamic Content
          Center(
            child: Text(
              'Third Page Placeholder',
              style: TextStyle(fontSize: 24),
            ),
          ),

          // Fourth Page - Placeholder for Image Page
          Center(
            child: Text(
              'Image Page',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
