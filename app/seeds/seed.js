var Post = require('../models/post');
var mongoose = require('mongoose');
var faker = require('faker');

async function seedDB() {
  try {
    if (process.env.DB_HOST) {
      await mongoose.connect(process.env.DB_HOST);
      console.log('Connected to database');

      await Post.deleteMany({});
      console.log('Database cleared');

      let posts = [];
      for (let i = 0; i < 100; i++) {
        posts.push({
          title: faker.random.words(),
          body: faker.lorem.paragraphs(),
        });
      }

      await Post.insertMany(posts);
      console.log("Database seeded with 100 records");
    }
  } catch (err) {
    console.error(err);
  } finally {
    mongoose.connection.close();
    console.log("Database connection closed");
  }
}

seedDB();
