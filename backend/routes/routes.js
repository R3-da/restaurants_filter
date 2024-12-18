const { Router } = require('express');
const router = Router();

const Restaurant = require('../models/restaurant');  // Import the Restaurant model
const CuisineType = require('../models/cuisinetype');  // Import the CuisineType model

// Route to get all restaurants
router.get('/api/restaurants', async (req, res) => {
  try {
    const restaurants = await Restaurant.findAll();  // Fetch all restaurants
    res.json({ restaurants });
  } catch (error) {
    console.error(error);
    res.status(500).send('Error retrieving restaurants');
  }
});

// Route to get all cuisine types
router.get('/api/cuisinetypes', async (req, res) => {
  try {
    const cuisineTypes = await CuisineType.findAll();  // Fetch all cuisine types
    res.json({ cuisineTypes });
  } catch (error) {
    console.error(error);
    res.status(500).send('Error retrieving cuisine types');
  }
});

module.exports = router;