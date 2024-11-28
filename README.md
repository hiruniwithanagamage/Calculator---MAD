Here's a sample README file for your calculator project written in Dart using Flutter:

---

# Flutter Calculator App

A simple yet functional calculator app built using **Flutter**. The app provides a responsive and user-friendly interface to perform basic arithmetic calculations and additional functionalities like percentage, square root, and toggling positive/negative numbers.

---

## Features

- Perform basic arithmetic operations: **Addition (+)**, **Subtraction (-)**, **Multiplication (x)**, and **Division (/)**.
- **Percentage calculation (%)**.
- **Square root** functionality (√).
- Toggle between **positive/negative** numbers (+/-).
- Clear the entire input (**AC** button).
- Backspace button (**⌫**) to remove the last character.
- Handles floating-point numbers with proper formatting.

---

## Demo

[Screen Recording MAD.webm](https://github.com/user-attachments/assets/113e3efc-dc15-4f82-a421-1fda1a821bfe)

---

## Screenshots
![image](https://github.com/user-attachments/assets/b48291db-0d8c-4d45-9cce-25c5acf5803b)

![Screenshot 2024-11-28 171133](https://github.com/user-attachments/assets/13bab6d4-0534-4bd1-9f38-966cba4ccb37)

![image](https://github.com/user-attachments/assets/d408b5f7-8969-4be5-acc8-32ba34f229af)


## Installation

### Prerequisites
- Ensure **Flutter SDK** is installed on your system.
- Supported on **Android** and **iOS** platforms.

### Steps

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/flutter-calculator-app.git
   cd flutter-calculator-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## Code Structure

- **`main.dart`**: The entry point of the app containing UI and logic.
- **Functions**:
  - `calculation(String btnText)`: Handles all button click events.
  - `evaluateExpression(String expression)`: Evaluates arithmetic expressions using stacks.
  - `doesContainDecimal(dynamic result)`: Formats the result to remove unnecessary decimal places.

---

## How to Contribute

1. Fork this repository.
2. Create a new branch for your feature:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push:
   ```bash
   git commit -m "Add feature-name"
   git push origin feature-name
   ```
4. Submit a pull request.

---

## Known Issues

- Division by zero results in a custom error message: *"Can't divide by zero"*.
- Large numbers may overflow the display area.

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Author

Developed by **[Hiruni Withanagamage](https://github.com/hiruniwithnagamage)**. Feel free to connect or contribute!

---

### Enjoy using the Flutter Calculator App! 🎉

