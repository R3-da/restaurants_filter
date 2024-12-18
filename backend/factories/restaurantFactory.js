const faker = require('faker');

// Function to generate an avatar URL based on the user's first name
const generateAvatar = (firstName) => {
  const initials = firstName.charAt(0).toUpperCase(); // Get the first letter of the first name
  return `https://ui-avatars.com/api/?name=${initials}&background=random&color=fff&size=256`; // Generates a random background color and white text color
};

const restaurantFactory = () => {
  const firstName = faker.company.companyName(); // Using company name for the restaurant name
  return {
    name: firstName,
    cuisineType: faker.random.arrayElement(['Italian', 'Mexican', 'Japanese', 'Chinese', 'Indian']),
    avatar: generateAvatar(firstName), // Generate avatar based on the first name's initial
  };
};

module.exports = restaurantFactory;