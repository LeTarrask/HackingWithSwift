### Project #12: Core Data
Take an in-depth tour of how SwiftUI and Core Data work together
1- Techniques:
[] - .self and ForEach, Hashable, how they are used to compare objects
[] - Creating NSManagedObject subclasses, to change how they work, and forego using XCode generated Code Data behavior.
[] - if self.moc.hasChanges { try? self.moc.save() }
[] - Using constraints to guarantee objects are unique in Core Data
[] - NSPredicate tem umas complicações, é uma mini query language cheia de pequenos truques.
[] - Filtrar os requests dinamicamente usando SwiftUI
[] - Object relationship in Code Data

2- Step-by-step:
O truque do if moc.hasChanges é bem interessante para evitar trabalho do Core Data, e os constraints para evitar dados duplicados.
This is basically a reading project, with small examples. The content here can be leveraged in my Mileage Tracker project.

3- Challenges:
