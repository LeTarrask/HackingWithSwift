### Project #15: Accessibility
Learn how to make your apps available to everyone
1- Techniques:
[] - .accesibility(label: Text()) - to simply tell over VoiceOver what something is
[] - .accessibility(hint:) - a long description that hints on the usage of something
[] - accesibility(addTraits: ) - to explain what that View is
[] - accesibility(removeTraits: .isImage) - to ignore describing an Image
[] - Image(decorative: ) - for something that doesn't need to be described in VoiceOver
[] - .accessibility(hidden: true) - makes something completely hidden to accessibility system
[] - .accessibilityElement(children: .combine) - to combine elements in a stack or group (like a few texts that shoulb be read together)
[] - .accessibilityElement(children: .ignore)
.accessibility(label: Text("Your score is 1000")) - can be used together to create a better reading experience
[] - .accessibility(value: Text("\(Int(estimate))")) - can be used to improve the reading of a slider, for example, and uses Int to be easier.

2- Step-by-step:
Fixing Guess the Flag.
Fixing Word Scramble.
Fixing Bookworm

3- Challenges:
Check out view in Cupcake Corner uses an image that doesn’t add anything to the UI (added the decorative: init to it); fix the steppers in BetterRest; full accesibility review of MoonShot (not today Satan).
