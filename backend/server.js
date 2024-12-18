// server.js
const express = require('express');
const cors = require('cors');
const routes = require('./routes/routes');
const sequelize = require('./db');  // Import the sequelize instance correctly

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use(routes);

// Sync the database before starting the server
sequelize.sync()
  .then(() => {
    console.log("Database synced successfully.");
    app.listen(port, () => {
      console.log(`Server running on port ${port}`);
    });
  })
  .catch((error) => {
    console.error("Error syncing database:", error);
  });