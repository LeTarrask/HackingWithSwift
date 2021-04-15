### Project #3: Views and Modifiers
Dive deep into Swift's rendering system
1- Techniques:
[] - Types of views
[] - View Modifiers and how they work
[] - Custom containers is interesting. He shows an example which is basically a Grid, like VGrid or HGrid, before it was introduced in Swift 2.0
[] - View Builders - he shows how to create a builder of a custom view
[] - Generics

2- Step-by-step:
Interesting code:

Template for View Modifier:
struct Title: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.largeTitle)
         .foregroundColor(.white)
         .padding()
         .background(Color.blue)
         .clipShape(RoundedRectangle(cornerRadius: 10))
       }
}

We can now use that with the modifier() modifier – yes, it’s a modifier called “modifier”, but it lets us apply any sort of modifier to a view, like this:

Text("Hello World")
   .modifier(Title())

When working with custom modifiers, it’s usually a smart idea to create extensions on View that make them easier to use. For example, we might wrap the Title modifier in an extension such as this:

extension View {
   func titleStyle() -> some View {
      self.modifier(Title())
   }
 }

 We can now use the modifier like this:

 Text("Hello World")
   .titleStyle()


3- Challenges:
Create a view modifier, add a modifier to exercise 1, add another modifier to exercise 2.
