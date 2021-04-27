### Project #5: Word Scramble
**There's a SwiftUI version - can skip**
Create an anagram game while learning about closures and booleans.
1- Techniques:
[] - txt file reading

2- Step-by-step:
We reuse a lot of knowledge here, like AlertController, actions, tableview. In the SwiftUI project, it's a lot more simpler to simply generate a list and edit it.

3- Challenges:
Disallow answers that are shorter than three letters or are just our start word (the tip is almost the answer); Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there; Add a left bar button item that calls startGame(); BONUS: fix a bug.
