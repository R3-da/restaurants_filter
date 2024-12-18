const { Router } = require('express');
const fs = require('fs');
const path = require('path');
const router = Router();
const Restaurant = require('../models/restaurant');  // Import the Restaurant model
const CuisineType = require('../models/cuisinetype');  // Import the CuisineType model

// Function to convert an image to base64
const convertImageToBase64 = (imagePath) => {
  try {
    const image = fs.readFileSync(imagePath);  // Read the image file
    return `data:image/jpeg;base64,${image.toString('base64')}`;  // Convert to base64 and return
  } catch (error) {
    console.error("Error reading image file:", error);
    return null;  // Return null if the image doesn't exist or can't be read
  }
};

// Route to get all restaurants
router.get('/api/restaurants', async (req, res) => {
  try {
    const restaurants = await Restaurant.findAll();  // Fetch all restaurants

    // Map through the restaurants to include the image data as base64
    const response = await Promise.all(
      restaurants.map(async (restaurant) => {
        const avatarFileName = restaurant.avatar; // The avatar field should store the image name (e.g., indian_food)

        // Loop through possible extensions to find the image
        const extensions = ['.jpg', '.jpeg', '.png'];  // Possible image extensions
        let base64Image = null;

        for (const ext of extensions) {
          const possibleImagePath = path.join(__dirname, '..', 'public', `${avatarFileName}`);
          if (fs.existsSync(possibleImagePath)) {
            base64Image = convertImageToBase64(possibleImagePath); // Convert the image to base64
            break;
          }
        }

        return {
          id: restaurant.id,
          name: restaurant.name,
          avatar: base64Image, // Return the base64 encoded image
          cuisineTypeId: restaurant.cuisineTypeId, // Include cuisineTypeId
        };
      })
    );

    res.json({ restaurants: response });
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

// Route to get restaurants by specific cuisine type
router.get('/api/restaurants/:cuisineTypeId', async (req, res) => {
  const { cuisineTypeId } = req.params; // Extract cuisineTypeId from request parameters

  try {
    const restaurants = await Restaurant.findAll({
      where: {
        cuisineTypeId: cuisineTypeId, // Filter restaurants by cuisineTypeId
      },
    });

    // If no restaurants found, return an empty array
    if (restaurants.length === 0) {
      return res.json({ restaurants: [] });
    }

    // Map through the restaurants to include the image data as base64
    const response = await Promise.all(
      restaurants.map(async (restaurant) => {
        const avatarFileName = restaurant.avatar; // The avatar field should store the image name (e.g., indian_food)

        // Loop through possible extensions to find the image
        const extensions = ['.jpg', '.jpeg', '.png'];  // Possible image extensions
        let base64Image = null;

        for (const ext of extensions) {
          const possibleImagePath = path.join(__dirname, '..', 'public', `${avatarFileName}`);
          if (fs.existsSync(possibleImagePath)) {
            base64Image = convertImageToBase64(possibleImagePath); // Convert the image to base64
            break;
          }
        }

        return {
          id: restaurant.id,
          name: restaurant.name,
          avatar: base64Image, // Return the base64 encoded image
          cuisineTypeId: restaurant.cuisineTypeId, // Include cuisineTypeId
        };
      })
    );

    res.json({ restaurants: response });
  } catch (error) {
    console.error(error);
    res.status(500).send('Error retrieving restaurants by cuisine type');
  }
});

module.exports = router;