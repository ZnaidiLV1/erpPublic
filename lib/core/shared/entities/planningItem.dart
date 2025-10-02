class PlanningItem {
  final String? title;
  final String? subtitle;
  final String? note;
  final String? image;
  final DateTime date;
  final PlanningType type;

  PlanningItem(
      this.title, this.subtitle, this.note, this.image, this.date, this.type);
}

enum PlanningType { Reminder, Event, Auther }

List<PlanningItem> planningItems = [
  PlanningItem("Nesrine Hope ", "hlorem loremmmmmm", "loremmm Leloremmmsson",
      null, DateTime.now(), PlanningType.Auther),
  PlanningItem(" [Rappel]"," La date limite de la tâche de devoirs", "Science Devoirs",
      null, DateTime.now(), PlanningType.Reminder),
  PlanningItem("Evenement", "en", "Pinture",
      null, DateTime.now(), PlanningType.Event),
  PlanningItem("Nesrine Hope ", "hlorem loremmmmmm", "loremmm Leloremmmsson",
      null, DateTime.now(), PlanningType.Auther),
  PlanningItem("Nesrine Hope ", "hlorem loremmmmmm", "loremmm Leloremmmsson",
      null, DateTime.now(), PlanningType.Auther),
];