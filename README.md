# ev4-logicParadigm-a01278252

---

### **Disclaimer**
This project was created using **AI tools** for translation, code generation, and consulting in some parts. However, the content, structure, and implementation of the project are **original** and reflect my own work.

---

# Song Recommendation System Based on a Finite Automaton

This project implements an **interactive system** to recommend songs based on genre, mood, or to display detailed information about a specific song. The system is built in **Prolog** and uses a **finite automaton** to manage state transitions and functionalities.

---

## 🧠 **Project Description**

The system functions as an interactive menu where the user can:
1. Get song recommendations by **musical genre**.
2. Get song recommendations based on their **mood**.
3. Consult detailed information about a specific song.

The program flow is designed as a **finite automaton**, with states representing menus or specific actions, and transitions that depend on the user's choices.

---

## 🚀 **Key Features**

- **Genre-Based Recommendations**: 
  - Allows the user to choose between musical genres such as pop, rock, regional, and others.
  - Displays a list of available songs in the selected genre.

- **Mood-Based Recommendations**:
  - Offers songs based on moods such as happy, nostalgic, melancholic, energetic, and others.
  - Displays a list of songs that match the entered mood.

- **Song Information**:
  - Allows searching and displaying detailed information about a specific song, including:
    - Name.
    - Genre.
    - Mood.
    - Artist.
    - Year of release.

---

## 📂 **Project Structure**

- **Database**:
  Contains information about the available songs, organized by genre, mood, artist, and year.

- **Finite Automaton**:
  Defines the states, transitions, and actions of the system to manage user interaction.

- **Interactive Interface**:
  Uses the automaton flow to guide the user through the system's functionalities.

---

## 📊 **Automaton Diagram**

Below is the automaton diagram that represents the system's flow:

![image](https://github.com/user-attachments/assets/39d3ad77-96f8-4b5b-be34-d43e1d78164a)

---

## 🛠️ **Requirements**

To run this project, you need:
- **SWI-Prolog**: A development environment for Prolog.
- A text editor or IDE compatible with Prolog.

---

## 🌟 **Usage Example**

### Main Menu:
```
Welcome. What would you like to do?
1. Recommendation by genre
2. Recommendation by mood
3. Show information about a song
```

### Genre Recommendation:
```
What genre do you prefer? (pop/rock/rap)
> pop
Recommended songs:
- Perfect
- All of Me
- Blinding Lights
```

### Song Information:
```
Which song would you like information about? (write the name in single quotes)
> 'Perfect'
Song information:
Name: Perfect
Genre: pop
Mood: romantic
Artist: Ed Sheeran
Year: 2017
```

---

## 🛠️ **Technical Details of Program Functionality**

The system is designed as a **finite automaton**, where functionalities and transitions are managed through states and actions defined in Prolog. Below is a technical explanation of how the program works:

---

### **1. Automaton States and Transitions**

The program uses the following key elements:

- **States**:
  Represent the different points in the program's flow. Example:
  - `a`: Main menu.
  - `b`: Functionality selection.
  - `c`, `d`, `e`: Specific processes for each functionality (genre, mood, song information).
  - `h`: Acceptance state where the user can finish or return to the menu.
  - `fin`: Absolute final state where the program terminates.

- **Transitions**:
  Transitions are defined using the predicate `transicion/3`:
  ```prolog
  transicion(CurrentState, Action, NextState).
  ```
  Example:
  ```prolog
  transicion(a, choose_functionality, b).
  ```
  Indicates that by choosing a functionality from state `a`, the program transitions to state `b`.

---

### **2. General Program Flow**

1. **Start**:
   - The program begins in state `a` and displays a main menu with three options:
     - Recommendation by genre.
     - Recommendation by mood.
     - Show information about a song.

2. **Functionality Selection**:
   - Based on the selected option, the program transitions to the corresponding state:
     - `c`: Recommendation by genre.
     - `d`: Recommendation by mood.
     - `e`: Show information about a song.

3. **Data Processing**:
   - In states `c`, `d`, and `e`, the program requests data from the user (genre, mood, or song name) and performs searches in the database using `findall/3` or direct queries.

4. **Results**:
   - Displays the results to the user:
     - List of recommended songs (by genre or mood).
     - Detailed information about a song.
   - Then transitions to state `h`, where the user can decide whether to finish or return to the main menu.

5. **Termination**:
   - If the user decides to finish, the program transitions to state `fin` and terminates.

---

### **3. Handling Incorrect Cases**

The program is designed to handle incorrect or invalid inputs robustly, ensuring that the system does not crash or stop abruptly.

#### **Common Incorrect Cases**

1. **Selecting an invalid option in the main menu**:
   - If the user enters a number outside the allowed range or a non-numeric value.
   - **Example**:
     ```
     Welcome. What would you like to do?
     1. Recommendation by genre
     2. Recommendation by mood
     3. Show information about a song
     > 4
     Invalid option.
     ```
   - The program returns to state `a` and prompts for input again.

2. **Entering a non-existent genre**:
   - If the user selects a musical genre that is not in the database.
   - **Example**:
     ```
     What genre do you prefer? (pop/rock/rap)
     > jazz
     There are no songs of that genre.
     ```
   - The program returns to state `g` and allows the user to decide whether to finish or return to the menu.

3. **Entering an invalid mood**:
   - If the user enters a mood that is not in the database.
   - **Example**:
     ```
     What mood are you in? (happy/sad/epic/energetic/nostalgic/motivational)
     > bored
     There are no songs for that mood.
     ```
   - The program returns to state `j` and allows the user to decide whether to finish or return to the menu.

4. **Searching for a non-existent song**:
   - If the user searches for information about a song that is not in the database.
   - **Example**:
     ```
     Which song would you like information about? (write the name in single quotes)
     > 'Unknown Song'
     Song not found.
     ```
   - The program returns to state `l` and allows the user to decide whether to finish or return to the menu.

---

### **4. Database and Queries**

- The song database is defined using facts in Prolog:
  ```prolog
  cancion(Name, Genre, Mood, Artist, Year).
  ```
  Example:
  ```prolog
  cancion('Perfect', 'pop', 'romantic', 'Ed Sheeran', 2017).
  ```

- Searches are performed using the `findall/3` predicate to generate lists of results:
  ```prolog
  findall(Name, cancion(Name, Genre, _, _, _), List).
  ```
  This allows retrieving all songs of a specific genre.

---

### **5. Complete Flow Example**

#### **Correct Case**:
1. User selects "Recommendation by genre."
2. Enters "pop."
3. The program displays a list of pop songs.
4. The user decides to return to the main menu.

#### **Incorrect Case**:
1. User selects "Recommendation by mood."
2. Enters an invalid mood, such as "bored."
3. The program displays an error message and allows the user to retry or return to the menu.

---

### **6. Technical Summary**

- **Resilience**: The program handles incorrect inputs by displaying clear error messages and allowing the user to retry.
- **Modularity**: Each functionality is separated into specific states, making the code easier to understand and maintain.
- **Interactivity**: User interaction is guided and structured, ensuring a smooth experience.

