# Project Outline
- [x] Core API for drawing and scene management (David Moore – @DaveAMoore)
- [ ] Grid logic for bomb locations and point values (David Moore – @DaveAMoore)
  - [ ] Create `Block` object to store pertinent information
  - [ ] Use 2D arrays to maintain matrix-like `Block` collection
- [ ] Scoring system (Wilson Mak – @DasNinjaWX)
  - [ ] High score storage (disk read & write)
- [ ] Bomb field drawing (Wilson Mak – @DasNinjaWX)
  - [ ] User interaction
  - [ ] Make appropriate API calls
- [ ] GUI (Unassigned, please contact)
  - [ ] Main menu
  - [ ] Score display
  - [ ] Restart button (smiley face)
  - [ ] Timer

### Assignments
Team members will be assigned specific components to develop and test. It is important that such members perform the necessary tasks to ensure maximum compatibility and stability. Failure to comply with these requirements may result in the rejection of a pull request, ultimately limiting contribution capacity.

### Testing
There are two particular types of testing that will be acceptable for this project: *interactive testing* and *unit testing*.

#### Interactive Testing
Manual tests performed by physical interaction will be accepted, as this is a high school programming course. However, it is important to note that in the future, such tests will not be deemed sufficient. An example of this method is the following: You build the GUI interface and run the program to ensure it works as intended.

#### Unit Testing
Unit testing is significantly more effective and rigorous than interactive testing, thus it is preferred for this and future projects.

1. Begin by defining the expected and desired output for a normal case, with correct input.
2. Implement the test case by declaring a class, naming it something simple like `BlockTests`, and then add the test methods to it.
  - Write a method and add the `@Test` notation above it.
  - In this method, perform assertions to check state and analyze the results. Refer to the Java reference for more information.
  - Ensure your method will run.
3. Add other test cases as required.
  - Test that your method handles `null` inputs gracefully.
4. Leave analysis and execution of the test cases to a member with commit privilege.

----
## Minesweeper
In this assignment, you will create a game like [Minesweeper](https://youtu.be/MPKXNLkDz10), as a class. Your game board should be 10x10, with a score displayed, a restart button (the smiley face), and a timer. View the video above for the rules of the game. This is a group project, so you, as a class, will hand in one copy of this assignment. Each student will be responsible to complete functions of the assignment that contributes to the overall assignment. You will be required to use the [discussion board](https://npsc.elearningontario.ca/d2l/common/dialogs/quickLink/quickLink.d2l?ou=11974765&type=discuss&rcode=eLO-18841663) for the assignment so that I can see who is doing what. Also, be sure to comment in each function or block of code who is responsible for creating it.

### You will be required to create the following:
As a group project, you will be required to work as a team to develop the program. Also, as part of a team, you will be required to do your share of the work and contribute to the project. In order for me to be witness to this group effort, communication for the assignment will need to be on the [discussion board](https://npsc.elearningontario.ca/d2l/common/dialogs/quickLink/quickLink.d2l?ou=11974765&type=discuss&rcode=eLO-18841663) for this assignment. You are required to contribute to the discussion needed to complete the assignment. This can be as simple as offering to create a certain function of the game, or something as complex as solving a critical problem that involves direct application of programming paradigms.

### Contributing
Contributions to this project are required by all members of ICS 4UV. As such, discussion and development shall take place in the appropriate locations to ensure proper evaluation may take place.

Particular components will be assigned to members of the development team. Those members will be expected to develop and test their code using appropriate methods (e.g., unit testing and/or interactive testing). Any changes made must be approved in the form of a pull request, which must contain certain critical information regarding the proposed changes. Follow the pull request template adequately for the best results.
