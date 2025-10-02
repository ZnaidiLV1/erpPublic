import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../presentation/absence/absence_screen.dart';
import '../../presentation/animatrice/animatrice_screen.dart';
import '../../presentation/badeges/badge_screen.dart';
import '../../presentation/children/children_screen.dart';
import '../../presentation/class_room/class_room_screen.dart';
import '../../presentation/club/club_screen.dart';
import '../../presentation/contine/contine_body.dart';
import '../../presentation/dashboard/dashboard.dart';
import '../../presentation/driver/driver_screen.dart';
import '../../presentation/events/components/events_body.dart';
import '../../presentation/finance/finance_screen.dart';
import '../../presentation/invoice/invoice_screen.dart';
import '../../presentation/planning/planning_screen.dart';
import '../../presentation/progess/progress_screen.dart';
import '../components/app_bar.dart';
import '../components/side_bar.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _controller.selectedIndex;
    _controller.addListener(_updateSelectedIndex);
  }

  void _updateSelectedIndex() {
    setState(() {
      _selectedIndex = _controller.selectedIndex;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSelectedIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: _key,
      drawer: CustomSideBar(controller: _controller),
      body: Row(
        children: [
          if (!isSmallScreen) CustomSideBar(controller: _controller),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: DashboardHeader(title: getTitle(_selectedIndex)),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) {
                          switch (_controller.selectedIndex) {
                            case 0:
                              return const Dashboard();
                            case 1:
                              return const ChildrenScreen();
                            case 2:
                              return const AnimatriceScreen();
                            case 3:
                              return const Contine();
                            case 4:
                              return const EventsPage();
                            case 5:
                              return const ClassRoomScreen();
                            case 7:
                              return const DriverScreen();
                            case 8:
                              return const AbsenceScreen();
                            case 9:
                              return PlanningScreen();
                            case 10:
                              return const InvoiceScreen();
                            case 12:
                              return const FinanceScreen();
                            case 13:
                              return const BadgeScreen();
                            case 14:
                              return const ProgressScreen();
                            case 15:
                              return const ClubScreen();
                            default:
                              return const Dashboard();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Tableau de bord";
      case 1:
        return "Enfants";
      case 2:
        return "Animatrice";
      case 3:
        return "Cantine&Gouter";
      case 4:
        return "Événement";
      case 5:
        return "Classe";
      case 6:
        return "Calandrier";
      case 7:
        return "Chauffeur";
      case 8:
        return "Absence";
      case 9:
        return "Planning";
      case 10:
        return "Facturation";
      case 11:
        return "Discussion";
      case 12:
        return "Finance";
      case 13:
        return "Badges";
      case 14:
        return "Progression suivie";
      case 15:
        return "Clubs";
      default:
        return "Dashboard";
    }
  }
}
