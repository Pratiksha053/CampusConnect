import 'package:flutter/material.dart';

void main() {
  runApp(const CampusConnectApp());
}

const Color primaryPurple = Color(0xFF6C4CF1);
const Color lightPurple = Color(0xFFF0ECFF);
const Color darkText = Color(0xFF201B3C);
const Color mutedText = Color(0xFF85839A);

class CampusConnectApp extends StatelessWidget {
  const CampusConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusConnect',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F7FC),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryPurple),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F7FC),
          foregroundColor: darkText,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class CampusEvent {
  final String title;
  final String category;
  final String date;
  final String time;
  final String venue;
  final String organizer;
  final String description;
  final IconData icon;
  final Color color;
  final String tag;

  const CampusEvent({
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.venue,
    required this.organizer,
    required this.description,
    required this.icon,
    required this.color,
    required this.tag,
  });
}

const List<CampusEvent> events = [
  CampusEvent(
    title: 'Campus Hackathon',
    category: 'Technology',
    date: '20 OCT 2026',
    time: '10:00 AM',
    venue: 'Innovation Lab',
    organizer: 'Demo: Coding Club',
    description:
    'Team up, solve real-world problems, build creative solutions, '
        'and showcase your coding skills in this sample campus event.',
    icon: Icons.terminal_rounded,
    color: Color(0xFF7057F5),
    tag: 'TECH',
  ),
  CampusEvent(
    title: 'Cultural Fiesta',
    category: 'Cultural',
    date: '25 OCT 2026',
    time: '11:00 AM',
    venue: 'Main Auditorium',
    organizer: 'Demo: Cultural Committee',
    description:
    'Celebrate campus life with music, dance, performances, '
        'and creativity. This is a sample event for the app demo.',
    icon: Icons.auto_awesome_rounded,
    color: Color(0xFFFF8A65),
    tag: 'CULTURE',
  ),
  CampusEvent(
    title: 'Creative Design Lab',
    category: 'Workshop',
    date: '28 OCT 2026',
    time: '02:00 PM',
    venue: 'Design Studio',
    organizer: 'Demo: Design Club',
    description:
    'Explore UI design, creative thinking, and prototyping '
        'through a sample hands-on workshop.',
    icon: Icons.palette_rounded,
    color: Color(0xFF22B8A7),
    tag: 'DESIGN',
  ),
  CampusEvent(
    title: 'Career Launchpad',
    category: 'Career',
    date: '02 NOV 2026',
    time: '12:00 PM',
    venue: 'Seminar Hall',
    organizer: 'Demo: Career Development Cell',
    description:
    'Explore career paths, learn interview preparation tips, '
        'and discover ways to prepare for internships.',
    icon: Icons.rocket_launch_rounded,
    color: Color(0xFF4787F5),
    tag: 'CAREER',
  ),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
int selectedTab = 0;
String selectedCategory = 'All';
String searchText = '';
final Set<String> savedEvents = {};
final TextEditingController searchController = TextEditingController();

final List<String> categories = [
'All',
'Technology',
'Cultural',
'Workshop',
'Career',
];

@override
void dispose() {
searchController.dispose();
super.dispose();
}

List<CampusEvent> get filteredEvents {
return events.where((event) {
final matchesCategory = selectedCategory == 'All' ||
event.category == selectedCategory;

final matchesSearch =
event.title.toLowerCase().contains(searchText.toLowerCase()) ||
event.category.toLowerCase().contains(searchText.toLowerCase());

final matchesTab =
selectedTab != 2 || savedEvents.contains(event.title);

return matchesCategory && matchesSearch && matchesTab;
}).toList();
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: SafeArea(
child: IndexedStack(
index: selectedTab,
children: [
buildHome(),
buildExplore(),
buildSaved(),
buildProfile(),
],
),
),
bottomNavigationBar: NavigationBar(
selectedIndex: selectedTab,
onDestinationSelected: (index) {
setState(() {
selectedTab = index;
selectedCategory = 'All';
searchText = '';
searchController.clear();
});
},
backgroundColor: Colors.white,
indicatorColor: lightPurple,
destinations: const [
NavigationDestination(
icon: Icon(Icons.home_outlined),
selectedIcon: Icon(Icons.home_rounded),
label: 'Home',
),
NavigationDestination(
icon: Icon(Icons.explore_outlined),
selectedIcon: Icon(Icons.explore_rounded),
label: 'Explore',
),
NavigationDestination(
icon: Icon(Icons.bookmark_border_rounded),
selectedIcon: Icon(Icons.bookmark_rounded),
label: 'Saved',
),
NavigationDestination(
icon: Icon(Icons.person_outline_rounded),
selectedIcon: Icon(Icons.person_rounded),
label: 'Profile',
),
],
),
);
}

Widget buildHome() {
return ListView(
padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
children: [
Row(
children: [
Container(
height: 46,
width: 46,
decoration: BoxDecoration(
color: primaryPurple,
borderRadius: BorderRadius.circular(15),
),
child: const Icon(
Icons.school_rounded,
color: Colors.white,
size: 27,
),
),
const SizedBox(width: 12),
const Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'CampusConnect',
style: TextStyle(
color: darkText,
fontWeight: FontWeight.w800,
fontSize: 19,
),
),
Text(
'Your campus, your community',
style: TextStyle(color: mutedText, fontSize: 11),
),
],
),
),
IconButton.filledTonal(
onPressed: () {
setState(() => selectedTab = 2);
},
style: IconButton.styleFrom(
backgroundColor: lightPurple,
foregroundColor: primaryPurple,
),
icon: const Icon(Icons.bookmark_outline_rounded),
),
],
),
const SizedBox(height: 28),
const Text(
'Make campus life',
style: TextStyle(
fontSize: 29,
fontWeight: FontWeight.w800,
color: darkText,
height: 1.2,
),
),
const Text(
'more exciting ✨',
style: TextStyle(
fontSize: 29,
fontWeight: FontWeight.w800,
color: primaryPurple,
height: 1.2,
),
),
const SizedBox(height: 10),
const Text(
'Discover events, meet people and find your next opportunity.',
style: TextStyle(
color: mutedText,
fontSize: 14,
height: 1.5,
),
),
const SizedBox(height: 22),
buildSearch(),
const SizedBox(height: 22),
buildSmartMatchBanner(),
const SizedBox(height: 28),
sectionHeading('Explore categories', 'Find your vibe'),
const SizedBox(height: 15),
buildCategories(),
const SizedBox(height: 28),
sectionHeading('Upcoming events', 'See all'),
const SizedBox(height: 14),
...filteredEvents.map((event) => buildEventCard(event)),
const SizedBox(height: 10),
buildDemoNotice(),
],
);
}

Widget buildExplore() {
return ListView(
padding: const EdgeInsets.all(20),
children: [
const Text(
'Explore events',
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.w800,
color: darkText,
),
),
const SizedBox(height: 8),
const Text(
'Find something exciting to be part of.',
style: TextStyle(color: mutedText),
),
const SizedBox(height: 22),
buildSearch(),
const SizedBox(height: 20),
buildCategories(),
const SizedBox(height: 20),
...filteredEvents.map((event) => buildEventCard(event)),
buildDemoNotice(),
],
);
}

Widget buildSaved() {
final saved = events
.where((event) => savedEvents.contains(event.title))
.toList();

return ListView(
padding: const EdgeInsets.all(20),
children: [
const Text(
'Saved events ❤️',
style: TextStyle(
fontSize: 27,
fontWeight: FontWeight.w800,
color: darkText,
),
),
const SizedBox(height: 8),
const Text(
'Your favourite events, all in one place.',
style: TextStyle(color: mutedText),
),
const SizedBox(height: 20),
if (saved.isEmpty)
emptyState(
Icons.bookmark_border_rounded,
'Nothing saved yet',
'Tap the bookmark on an event to save it here.',
),
...saved.map((event) => buildEventCard(event)),
buildDemoNotice(),
],
);
}

Widget buildProfile() {
return ListView(
padding: const EdgeInsets.all(22),
children: [
const SizedBox(height: 24),
Center(
child: Container(
width: 100,
height: 100,
decoration: BoxDecoration(
color: lightPurple,
borderRadius: BorderRadius.circular(32),
),
child: const Icon(
Icons.school_rounded,
size: 52,
color: primaryPurple,
),
),
),
const SizedBox(height: 18),
const Center(
child: Text(
'CampusConnect',
style: TextStyle(
fontSize: 25,
fontWeight: FontWeight.w800,
color: darkText,
),
),
),
const SizedBox(height: 8),
const Center(
child: Text(
'Your student community',
style: TextStyle(color: mutedText),
),
),
const SizedBox(height: 28),
profileTile(
Icons.bookmark_rounded,
'Saved events',
'${savedEvents.length} events saved',
() => setState(() => selectedTab = 2),
),
profileTile(
Icons.auto_awesome_rounded,
'Smart Event Match',
'Discover events based on your interests',
showMatchDialog,
),
profileTile(
Icons.info_outline_rounded,
'About CampusConnect',
'A student event discovery demo',
() {
showDialog<void>(
context: context,
builder: (context) => AlertDialog(
title: const Text('About CampusConnect'),
content: const Text(
'CampusConnect helps students discover campus activities. '
'This prototype uses sample events and local demo data.',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: const Text('Close'),
),
],
),
);
},
),
buildDemoNotice(),
],
);
}

Widget buildSearch() {
return TextField(
controller: searchController,
onChanged: (value) => setState(() => searchText = value),
decoration: InputDecoration(
hintText: 'Search events, workshops...',
hintStyle: const TextStyle(color: mutedText, fontSize: 13),
prefixIcon: const Icon(Icons.search_rounded, color: primaryPurple),
filled: true,
fillColor: Colors.white,
contentPadding: const EdgeInsets.symmetric(vertical: 16),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
),
);
}

Widget buildSmartMatchBanner() {
return Container(
padding: const EdgeInsets.all(21),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [Color(0xFF785CF6), Color(0xFF4C35C8)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(25),
boxShadow: [
BoxShadow(
color: primaryPurple.withValues(alpha: 0.20),
blurRadius: 18,
offset: const Offset(0, 8),
),
],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Container(
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.white.withValues(alpha: 0.18),
borderRadius: BorderRadius.circular(13),
),
child: const Icon(
Icons.auto_awesome_rounded,
color: Colors.white,
size: 26,
),
),
const Spacer(),
const Text(
'SMART MATCH',
style: TextStyle(
color: Colors.white70,
fontSize: 10,
fontWeight: FontWeight.bold,
letterSpacing: 1.5,
),
),
],
),
const SizedBox(height: 18),
const Text(
'Your next favourite\ncampus experience.',
style: TextStyle(
color: Colors.white,
fontSize: 23,
height: 1.25,
fontWeight: FontWeight.w800,
),
),
const SizedBox(height: 9),
const Text(
'Discover events that match your interests.',
style: TextStyle(color: Colors.white70, fontSize: 13),
),
const SizedBox(height: 17),
FilledButton(
onPressed: showMatchDialog,
style: FilledButton.styleFrom(
backgroundColor: Colors.white,
foregroundColor: primaryPurple,
padding: const EdgeInsets.symmetric(
horizontal: 18,
vertical: 13,
),
),
child: const Row(
mainAxisSize: MainAxisSize.min,
children: [
Text('Find my match'),
SizedBox(width: 8),
Icon(Icons.arrow_forward_rounded, size: 17),
],
),
),
],
),
);
}

void showMatchDialog() {
showModalBottomSheet<void>(
context: context,
showDragHandle: true,
backgroundColor: Colors.white,
builder: (context) {
return Padding(
padding: const EdgeInsets.fromLTRB(22, 8, 22, 30),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'What are you interested in?',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.w800,
color: darkText,
),
),
const SizedBox(height: 8),
const Text(
'Choose an interest to find matching demo events.',
style: TextStyle(color: mutedText),
),
const SizedBox(height: 18),
...categories.skip(1).map(
(category) => ListTile(
leading: const Icon(
Icons.auto_awesome_rounded,
color: primaryPurple,
),
title: Text(category),
trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
onTap: () {
Navigator.pop(context);
setState(() {
selectedTab = 1;
selectedCategory = category;
searchText = '';
searchController.clear();
});
},
),
),
],
),
);
},
);
}

Widget buildCategories() {
return SizedBox(
height: 42,
child: ListView.separated(
scrollDirection: Axis.horizontal,
itemCount: categories.length,
separatorBuilder: (context, index) => const SizedBox(width: 9),
itemBuilder: (context, index) {
final category = categories[index];
final selected = selectedCategory == category;

return ChoiceChip(
label: Text(category),
selected: selected,
showCheckmark: false,
onSelected: (_) {
setState(() => selectedCategory = category);
},
selectedColor: primaryPurple,
backgroundColor: Colors.white,
labelStyle: TextStyle(
color: selected ? Colors.white : mutedText,
fontWeight: FontWeight.w600,
fontSize: 12,
),
side: BorderSide(
color: selected ? primaryPurple : const Color(0xFFECEAF3),
),
);
},
),
);
}
Widget sectionHeading(String title, String action) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Text(
        action,
        style: const TextStyle(
          color: primaryPurple,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget buildEventCard(CampusEvent event) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFF0EEF6)),
      boxShadow: [
        BoxShadow(
          color: darkText.withValues(alpha: 0.035),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => openEventDetails(event),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 135,
              width: double.infinity,
              decoration: BoxDecoration(
                color: event.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    event.color.withValues(alpha: 0.18),
                    event.color.withValues(alpha: 0.07),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 13,
                    child: Icon(
                      event.icon,
                      size: 102,
                      color: event.color.withValues(alpha: 0.85),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        event.tag,
                        style: TextStyle(
                          color: event.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    bottom: 15,
                    child: Text(
                      event.date,
                      style: TextStyle(
                        color: event.color,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: IconButton(
                      tooltip: savedEvents.contains(event.title)
                          ? 'Remove bookmark'
                          : 'Save event',
                      onPressed: () {
                        setState(() {
                          if (savedEvents.contains(event.title)) {
                            savedEvents.remove(event.title);
                          } else {
                            savedEvents.add(event.title);
                          }
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryPurple,
                      ),
                      icon: Icon(
                        savedEvents.contains(event.title)
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              event.title,
              style: const TextStyle(
                color: darkText,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 15,
                  color: mutedText,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    event.time,
                    style: const TextStyle(color: mutedText, fontSize: 12),
                  ),
                ),
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: mutedText,
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    event.venue,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: mutedText, fontSize: 12),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: primaryPurple,
                  size: 19,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void openEventDetails(CampusEvent event) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => EventDetailsPage(
        event: event,
        isSaved: savedEvents.contains(event.title),
        onSave: () {
          setState(() {
            if (savedEvents.contains(event.title)) {
              savedEvents.remove(event.title);
            } else {
              savedEvents.add(event.title);
            }
          });
        },
      ),
    ),
  );
}

Widget buildDemoNotice() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF5DF),
      borderRadius: BorderRadius.circular(13),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline_rounded, color: Color(0xFF946500), size: 19),
        SizedBox(width: 9),
        Expanded(
          child: Text(
            'Prototype demo: event dates, venues and organisers are sample '
                'data, not verified college announcements.',
            style: TextStyle(
              color: Color(0xFF795D19),
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget emptyState(IconData icon, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 70),
    child: Column(
      children: [
        Icon(icon, size: 65, color: primaryPurple.withValues(alpha: 0.5)),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: mutedText),
        ),
      ],
    ),
  );
}

Widget profileTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
    ) {
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: lightPurple,
        child: Icon(icon, color: primaryPurple),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: darkText,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    ),
  );
}
}

class EventDetailsPage extends StatefulWidget {
  final CampusEvent event;
  final bool isSaved;
  final VoidCallback onSave;

  const EventDetailsPage({
    super.key,
    required this.event,
    required this.isSaved,
    required this.onSave,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool registered = false;
  late bool saved;

  @override
  void initState() {
    super.initState();
    saved = widget.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: AppBar(
        title: const Text(
          'Event details',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.onSave();
              setState(() => saved = !saved);
            },
            icon: Icon(
              saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: primaryPurple,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: event.color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(27),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(event.icon, size: 125, color: event.color),
                ),
                Positioned(
                  left: 15,
                  bottom: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      event.tag,
                      style: TextStyle(
                        color: event.color,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            event.category.toUpperCase(),
            style: const TextStyle(
              color: primaryPurple,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            event.title,
            style: const TextStyle(
              color: darkText,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          detailTile(Icons.calendar_month_rounded, 'Date', event.date),
          detailTile(Icons.access_time_rounded, 'Time', event.time),
          detailTile(Icons.location_on_rounded, 'Venue', event.venue),
          detailTile(Icons.groups_rounded, 'Organiser', event.organizer),
          const SizedBox(height: 20),
          const Text(
            'About this event',
            style: TextStyle(
              color: darkText,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            event.description,
            style: const TextStyle(
              color: mutedText,
              fontSize: 14,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5DF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Text(
              'Demo only: this prototype does not contact the organiser '
                  'or submit a real registration.',
              style: TextStyle(
                color: Color(0xFF795D19),
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 54,
            child: FilledButton(
              onPressed: () {
                setState(() => registered = !registered);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      registered
                          ? 'Demo registration noted!'
                          : 'Demo registration cancelled.',
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                registered ? 'Registered (Demo)' : 'Register for event',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: lightPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryPurple, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: mutedText, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: darkText,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}