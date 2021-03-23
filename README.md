# Snowmanlabs FAQ Demo
*iOS demo application to display a FAQ example*

---
## Project Description

Basic demonstration of a FAQ screen, where the user can also create a new question/answer. The FAQ screen also contains a searchbar.  Each FAQ item should contain:

1. Question;
2. Answer when expanded (clicked);

---

**Besides the listed basic info that the application will show, it must also fulfill the following requisites:**

1. The application must be written in Swift;
2. The application should store data locally;
3. Backend service is optional; 

---
### User stories
1. As a user, I want to view the list of questions/answers (FAQ).
2. As a user, I want to click on a question and want the answer to be showed.
3. As a user, I want to be able to search for questions/answers.
4. As a user, I want to be able to create a new question/answer.
5. As a user, I want to be able to add a color to my question/answer.

---
## Instructions
1. There are no pods on this project, so no need to run podinstall or any dependecy manager;
2. App was mainly developed for iPhone, but also has a layout for iPad, not tested 100%
3. At the first execution, the app will create a local database using default FAQ's questions listed on a json file. So, after unnistalling app, the questions are reseted to default ones

---
## Observations
1. My user had no access to download content or get colors/font sizes/constraints from the provided layout website. So the layout may differ a litle from the one provided.
2. To show question answer on FAQ screen, the click is being handled by the arrow on each cell, not by a click on the cell itself. This is how I understood it was supposed to be, but can be easily changed to cell click.


