### Project #11: Bookworm
Use Core Data to build an app that tracks books you like
1- Techniques:
[] - @Binding
[] - Size classes (@Environment(\.horizontalSizeClass) properties that can be used to return different views according to devices: .compact, for smaller ones or split screens, and .regular, for larger screens.)
[] - AnyView - a type erased wrapper (AnyView conforms to the same View protocol as Text, Color, VStack, and more, and it also contains inside it a view of a specific type. However, externally AnyView doesn’t expose what it contains – Swift sees our condition as returning either an AnyView or an AnyView, so it’s considered the same type. This is where the name “type erasure” comes from: AnyView effectively hides – or erases – the type of the views it contains.)
[] - Core Data
[] - Mocking data to preview Core Data objects in XCode preview
[] - FetchRequests
[] - NSSortDescriptors
[] - Create items, and save
[] - Delete items from moc
[] - Create one own's components to be reused
[] - Edit button to modify list

2- Step-by-step:
Let's start by creating stuff in Core Data. Created a basic core data input form, and a contentview that has a fetchrequest to show all the items. Then, a RatingsView that can be reused with Bindings. Then, we add items, delete items and fetch items, with a sort description.

3- Challenges:
It’s possible to select no genre for books - fix this, either by forcing a default, validating the form, or showing a default picture for unknown genres – you can choose. I've added "No genre" default value.; Modify ContentView so that books rated as 1 star have their name shown in red.; Add a new “date” attribute to the Book entity, assigning Date() to it so it gets the current
date and time, then format that nicely somewhere in DetailView.
