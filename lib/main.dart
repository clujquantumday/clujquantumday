import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../spoker_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cluj Quantum Day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0A0E21), // Dark background
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: Colors.white, fontSize: 24),
          bodyLarge: TextStyle(color: Colors.white70),
          labelLarge: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      home: const QuantumEventPage(),
    );
  }
}

class QuantumEventPage extends StatelessWidget {
  const QuantumEventPage({super.key});

      Future<void> _launchMyUrl() async {

    final Uri url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLScKZlBPWtgC1X1er6JhfjFsnMTY86EvYTj6NVHx_8mWGiQ2mQ/viewform?usp=dialog');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final GlobalKey _detailsKey = GlobalKey();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section - Full screen height for initial view
            Stack(
              children: [
                Container(
                  height: screenHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/quantum-hero.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: screenHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromRGBO(0, 0, 0, 0.3), // black with 30% opacity
                    Color.fromRGBO(0, 0, 0, 0.7), // black with 70% opacity
],
                    ),
                  ),
                ),
                
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: isMobile ? 150 : 250), // Added space to push content down towards center
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                          ).createShader(bounds),
                          child: Text(
                            'Cluj Quantum Day',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 36 : 48,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Embark on your Quantum Computing journey. Compute the impossible.',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: isMobile ? 18 : 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _launchMyUrl,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              ),
                              child: const Text('Register Now', style: TextStyle(color: Colors.white)),
                              
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                              onPressed: () {
                                Scrollable.ensureVisible(
                                  _detailsKey.currentContext!,
                                  alignment: 0.0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              ),
                              child: const Text('View Details', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Event Details Section
            Padding(
              key: _detailsKey,
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Text(
                    'Event Details',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 36),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Everything you need to know',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  isMobile
                      ? Column(
                          children: _buildDetailCards(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _buildDetailCards(),
                        ),
                ],
              ),
            ),
            // Event Schedule Section
            Container(
              color: const Color(0xFF0A0E21),
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Text(
                    'Event Schedule',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Full day of quantum computing exploration',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  ..._buildScheduleItems(),
                ],
              ),
            ),
           // Speakers Section
Container(
  padding: const EdgeInsets.all(32.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Speakers',
        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 36),
      ),
      const SizedBox(height: 8),
      Text(
        'Meet the experts and innovators of Quantum Day',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: 24),

      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const [
                 SpeakerCard(
                    name: 'Dr. Liviu Zarbo',
                    title: 'Senior research - ITIM',
                    //bio: 'Focus on quantum networks and implementations.',
                    photoAsset: 'assets/liviu_bw-1.jpg'
                  ),
                  SpeakerCard(
                    name: 'Sorin Bolos',
                    title: 'Transilvania Quantum',
                    //rbio: 'Builds tools for quantum simulation.',
                    photoAsset: 'assets/SorinBolos.jpeg',
                  ),
                  SpeakerCard(
                    name: 'Cristian Ilie',
                    title: 'Phd Student, UPB',
                    //bio: 'Works on algorithms and error correction.',
                    photoAsset: 'assets/CristiH-H.jpeg',
                  ),
     
           
                ],
              ),
            ],
          ),
        ),


            // CTA Section
            Container(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ).createShader(bounds),
                    child: Text(
                      '2025 Sponsors : Stayed tuned !',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 32),
                  Text(
                      'Ready for the Quantum Journey?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 20 : 24, // Smaller on mobile
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 16),
                   
                  ElevatedButton(
                  onPressed: _launchMyUrl,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Register Now', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
          
                ],
              ),
            ),
            // Footer
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Organized in colaboration with UNITECH CLuj',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'For questions, contact: Roman.Ca.Tudor@student.utcluj.ro',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDetailCards() {
    return [
      _DetailCard(
        icon: Icons.calendar_today,
        title: 'When',
        content: '8 November, 2025',
      ),
      const SizedBox(height: 16, width: 16),
      _DetailCard(
        icon: Icons.location_on,
        title: 'Where',
        content: 'Universitatea Tehnica Cluj-Napoca\nCladirea BT\n',
      ),
      const SizedBox(height: 16, width: 16),
      _DetailCard(
        icon: Icons.people,
        title: 'Who',
        content: 'Beginners to intermediate',
      ),
    ];
  }

  List<Widget> _buildScheduleItems() {
    final schedule = [
      {'time': '09:00', 'title': 'Registration', 'desc': 'Welcome and check-in for all participants', 'color': Colors.blue[800], 'icon': Icons.app_registration},
      {'time': '09:45', 'title': 'Opening Ceremony', 'desc': 'Kickoff presentation and event overview', 'color': Colors.teal[800], 'icon': Icons.mic},
      {'time': '10:30', 'title': 'Workshops & Speaking Sessions', 'desc': 'Deep dive into quantum computing concepts and technologies', 'color': Colors.purple[800], 'icon': Icons.school},
      {'time': '13:00', 'title': 'Lunch Break', 'desc': '', 'color': Colors.green[800], 'icon': Icons.restaurant},
      {'time': '13:45', 'title': 'Practical Activities', 'desc': 'Mini Hackathon', 'color': Colors.indigo[800], 'icon': Icons.code},
      {'time': '18:00', 'title': 'Closing & Awards Ceremony', 'desc': '', 'color': Colors.deepPurple[800], 'icon': Icons.emoji_events},
    ];

    return schedule.map((item) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color:  Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((255 * 0.2).round()),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item['color'] as Color?,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item['time'] as String,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Row(
            children: [
              Icon(item['icon'] as IconData, color: Colors.blueAccent),
              const SizedBox(width: 8),
              Text(item['title'] as String, style: const TextStyle(color: Colors.white)),
            ],
          ),
          subtitle: item['desc'] != '' ? Text(item['desc'] as String, style: const TextStyle(color: Colors.white70)) : null,
        ),
      );
    }).toList();
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _DetailCard({required this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 40),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

}