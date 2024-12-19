# Restaurant Filter - Demo App for Edit Your Art

## Demo Video:
https://github.com/user-attachments/assets/65be20e4-c2b7-4324-9d36-ff9b8d797505


## Project Requirements:
- **Backend**: Node.js v20.10.0
- **Frontend**: Flutter 3.24.4

---

## Setting Up the Backend

1. Navigate to the backend directory:

```zsh
cd backend
npx sequelize-cli db:migrate
npx sequelize-cli db:migrate
npm start
```


## Setting Up the Frontend

1.	Navigate to the frontend directory:

```zsh
cd frontend
flutter run
```

Alternatively, you can use the Flutter extension in Visual Studio Code for a smoother development experience.

---

## Important Notes

- This project was developed and tested on iOS simulators running iOS 18.0. 
- If you plan to run the project on an Android emulator, you may need to update the backend API URL from `localhost` to `10.0.2.2` to ensure proper communication between the frontend and backend.

---
