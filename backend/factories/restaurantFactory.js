const fs = require('fs');
const path = require('path');

// Function to generate an image path based on the cuisine name
const generateImage = (cuisineName) => {
  const cuisineTypeName = cuisineName.toString().toLowerCase().replace(/\s+/g, '_'); // Convert to string, lowercase, and replace spaces with underscores
  const extensions = ['.jpg', '.jpeg', '.png'];  // Possible image extensions

  // Loop through possible extensions to find the image
  for (const ext of extensions) {
    const imagePath = path.join(__dirname, '..', 'public', 'images', `${cuisineTypeName}_food${ext}`);
    if (fs.existsSync(imagePath)) {
      return `/images/${cuisineTypeName}_food${ext}`;  // Return the relative path to the image
    }
  }

  // If no image found, return null (or handle as you see fit)
  return null;
};

const restaurantFactory = (cuisineType) => {
  const firstName = `Restaurant ${cuisineType.name}`; // Use the cuisine name to generate the restaurant name
  const image = generateImage(cuisineType.name); // Generate image based on the cuisine name

  return {
    name: firstName,
    avatar: image, // Only use the image if it exists
  };
};

module.exports = restaurantFactory;