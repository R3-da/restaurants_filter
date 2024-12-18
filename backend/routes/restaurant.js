const { Router } = require('express');
const router = Router();

const Restaurant = require('../models/restaurant');  // Import the Restaurant model

router.get('/api/restaurants', async (req, res) => {
  try {
    const restaurants = await Restaurant.findAll();  // This should work now
    res.json({ restaurants });
  } catch (error) {
    console.error(error);
    res.status(500).send('Error retrieving restaurants');
  }
});

module.exports = router;