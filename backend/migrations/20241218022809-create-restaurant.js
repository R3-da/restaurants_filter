'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Restaurants', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      name: {
        type: Sequelize.STRING
      },
      cuisineTypeId: {  // Foreign key to CuisineTypes
        type: Sequelize.INTEGER,
        references: {
          model: 'CuisineTypes',  // Name of the CuisineTypes table
          key: 'id'
        },
        onUpdate: 'CASCADE',  // Optional: Update the foreign key when the referenced record is updated
        onDelete: 'SET NULL'  // Optional: Set the foreign key to NULL when the referenced record is deleted
      },
      avatar: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Restaurants');
  }
};