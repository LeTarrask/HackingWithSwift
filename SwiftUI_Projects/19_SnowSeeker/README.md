### Project #19: SnowSeeker
Build an app for ski resorts that works great on iPad.
1- Techniques:
[] - NavigationView and how views work in split screens (ex: iPads)
[] - Showing alerts when optional properties are set. This is way simpler than the way we've been using alerts. For example, there's an optional error. It only will show the alert when the error is created.
[] - Using Group to merge several views and later define their layout.
[] - sizeClass: .compact (small devices)
[] - To initialize a view inside a VStack, for example: VStack(content: UserView.init)
[] - ListFormatter - same behavior as joining an array of strings, but adds an "and" before the last one.
[] - Spacer.frame(height: 0) - for a spacer only work in horizontal formats

2- Step-by-step:
We have a model, decode from JSON, show it. All stuff we've seen before. The fun part is how the navigation views work in different Apple devices, the large ones and the small ones. This is the more challenging stuff, that we've not seen before.
This project is also suggested as a template app, to show objects and its details.

3- Challenges:
Add a photo credit over the ResortView image; Fill in the loading and saving methods for Favorites; For a real challenge, let the user sort and filter the resorts in ContentView. For sorting
use default, alphabetical, and country, and for filtering let them select country, size, or price (postponed).
