const { Sequelize, DataTypes } = require('sequelize');

require('dotenv').config();

const sequelize = new Sequelize('groupomania', 'root', '', {
  host: 'localhost',
  dialect: 'mysql',
});

module.exports = sequelize;
