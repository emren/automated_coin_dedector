## 1. Description
Automated coin dedector is a stream based application where stream is updated on fixed time basis. Stream will produce **Fake** and **Real** strings and user will see an updated list of expandable widgets showing string and time.

## 2. Chosen Technology
Flutter Channel stable, 2.2.3, implemented null safe  **sdk: ">=2.12.0 <3.0.0"**

## 3. Project Structure
As a best practice, UI and logic has been separated. This is achieved by collecting ui files under ui folder and logic under core folder.

## 4. State Management
For the state management **Provider** with **ChangeNotifier** has been implemented in this project. Changenotifier is Flutters own state solution, a wrapper for inherited widget, where it has notifylistener() function to update the widgets.

## 5. Packages Used
**provider** For state management

**rxdart** For stream subjects

**assets_audio_player** For sound implementation

**intl** For datetime formatting