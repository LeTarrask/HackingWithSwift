### Project #9: Grand Central Dispatch
Learn how to run complex tasks in the background with GCD.
1- Techniques:
[] - DispatcQueue
[] - .async
[] - All the theory explaining queues, threads, and which kind of instructions should run in which threads, backgrounds, etc.
[] - .main, .userInitiated, .userInteractive, .utility, .background (eram as mesmas em SwiftUI? R: não, não tinha GCD nos tutoriais de SwiftUI.) A razão parece ter sentido com o Combine: as operações em background são quase sempre feitas com dados, que devem correr em threads de background. A UI é que deve ser sempre atualizada na main thread. Porém, com Combine, as UI se atualizam automaticamente, quando percebem alguma alteração nas fontes de dados publicadas).
[] - Easy GCD using performSelector(inBackground:)

2- Step-by-step:
Implemented GCD in project 7, by adding a selector to fetch the JSON in the background, and whenever it updates, it comes back to the main thread and updates UI. It's a very simple project.

3- Challenges:
The challenges are to implement the same solution to other 3 projects: 1, 8, and 7 (to the filtering option).
Number 1 was quite simple.
NUmber 8, as well.
Filtering option not implemented in #7.
