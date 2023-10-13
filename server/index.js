const express = require("express");
const MongoClient = require("mongodb").MongoClient;
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Joi = require("joi");

const { ObjectId } = require("mongodb");

const app = express();
const router = express.Router();
app.use(bodyParser.json());
dotenv.config();

const port = 3000;
// const PORT = process.env.PORT;

const mongo_url = process.env.MONGODB_URL;
const jwtSecret = process.env.JWT_SECRET;

const client = new MongoClient(mongo_url);

const db = client.db("travelApp");
const destinationsCollection = db.collection("destinations");
const usersCollection = db.collection("users");

// Create a Mongoose model for the user
// const User = mongoose.model("User", {
//   userName: String,
//   email: String,
//   password: String,
//   bookmarkedCities: [String],
// });

// Validate the user input
const userSchema = Joi.object({
  userName: Joi.string(),
  email: Joi.string().email().required(),
  password: Joi.string().min(6).required(),
  bookmarkedCities: Joi.array().items(Joi.string()),
});

async function checkEmailStatus(email) {
  const user = await usersCollection.findOne({ email });
  return user !== null;
}

async function fetchUserData(id) {
  const objectId = ObjectId.createFromHexString(id);
  const user = usersCollection.findOne({ _id: objectId });
  return user;
}

app.get("/", (req, res) => {
  res.sendStatus("Hello World");
});

// Define GET /users endpoint
app.get("/users", async (req, res) => {
  const users = await usersCollection.find().toArray();

  res.json(users);
});

app.post("/signUp", async (req, res) => {
  const validationResult = userSchema.validate(req.body);
  if (validationResult.error) {
    res
      .status(400)
      .json({ message: validationResult.error.details[0].message });
  }

  const newUser = {
    userName: req.body.userName,
    email: req.body.email,
    password: req.body.password,
    bookmarkedCities: [],
  };

  if (!newUser.userName || !newUser.email || !newUser.password) {
    return res.status(400).json({ message: "All fields are required" });
  }

  const emailExists = await checkEmailStatus(newUser.email);

  if (emailExists) {
    return res.status(409).json({ message: "Email already exists" });
  }

  try {
    await usersCollection.insertOne(newUser);
    res.status(201).json({ message: "User created successfully", newUser });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Define POST /login to log the user in
app.post("/login", async (req, res) => {
  try {
    const validationResult = userSchema.validate(req.body);
    if (validationResult.error) {
      res
        .status(400)
        .json({ message: validationResult.error.details[0].message });
    }
    const email = req.body.email;
    const password = req.body.password;
    console.log("email ", email);

    if (!email || !password) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // Find the user in the database
    const user = await usersCollection.findOne({ email });

    // If the user does not exist, return an error response
    if (!user) {
      return res.status(401).json({ message: "Invalid email or password" });
    } else {
    }

    // Validate the password
    var isPasswordValid = await bcrypt.compare(password, user.password);

    if (isPasswordValid) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    // Generate a JWT token
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET);

    // Send user data
    const userId = user._id;
    const userEmail = user.email;
    const userBookmarkedCities = user.bookmarkedCities ?? [];

    // Return the token to the client

    res.status(200).json({
      message: "User successfully logged in",
      token,
      userId,
      userEmail,
      userBookmarkedCities,
    });
  } catch (error) {
    console.log(`Error: ${error}`);
    res.json({ message: error.message });
  }
});

// Define GET /user-data endpoint to get user-data
app.get("/user-data/:id", async (req, res) => {
  const id = req.params.id;

  console.log(`decodedToken: ${id}`);

  const user = await fetchUserData(id);
  if (!user) {
    return res.status(400).json({ message: "User not found" });
  }

  return res.status(200).json({ user });
});

// Define POST /bookmarks to add bookmarks to the users data

app.put("/users/:userId/bookmarks", async (req, res) => {
  // try {
  const userId = req.params.userId;
  const destinationId = req.body.destinationId;

  console.log("userId ", userId);
  console.log("destinationId ", destinationId);

  // Find the user in the database
  const user = await usersCollection.findOne({ _id: new ObjectId(userId) });
  // Initialize bookmarkedCities as an empty array if it's null
  if (user.bookmarkedCities == null) {
    user.bookmarkedCities = [];
  }
  // update the user's bookmarkedCities array
  if (user.bookmarkedCities.includes(destinationId)) {
    const index = user.bookmarkedCities.indexOf(destinationId);
    user.bookmarkedCities.splice(index, 1);
  } else {
    user.bookmarkedCities.push(destinationId);
  }

  await usersCollection.updateOne(
    { _id: new ObjectId(userId) },
    { $set: user }
  );
  res.status(200).json({ message: "Bookmarks updated successfully", user });
});

// Define GET /logout to log the user out
app.get("/logout", async (req, res) => {
  // Invalidate the user's JWT
  res.clearCookie("Authorization");

  // Send the response to the user indicating the user has been logged out
  res.status(200);
  res.json({ message: "User logged out successfully" });
});

app.get("/users", async (req, res) => {
  const users = await usersCollection.find().toArray();

  res.json(users);
});

// Define a route to find a user by ID
app.get("/users/:userId", (req, res) => {
  const userId = req.params.userId;

  console.log("userId ", userId);

  usersCollection.findOne({ _id: userId }, (err, user) => {
    if (err) {
      console.error("Error finding user:", err);
      res.status(500).json({ error: "Internal Server Error" });
      return;
    }

    if (!user) {
      res.status(404).json({ error: "User not found" });
      return;
    }

    res.json(user);
  });
});

// Define GET /destinations endpoint
app.get("/destinations", async (req, res) => {
  // Get all destinations from the database
  const destinations = await destinationsCollection.find().toArray();

  // Send the destinations back to the client
  res.json(destinations);
});

// Define the POST /cities endpoint
app.post("/destinations", async (req, res) => {
  // Get the city data from the request body
  const city = {
    cityName: req.body.cityName,
    country: req.body.country,
    bookmarkStatus: req.body.bookmarkStatus,
    attractions: req.body.attractions,
    cityInfo: req.body.cityInfo,
    cityImages: req.body.cityImages,
  };

  // Insert the city into the database
  await destinationsCollection.insertOne(city);

  // Send a success response to the client
  res.status(201).json({ message: "City created successfully" });
});

// Define GET /destination/:id route to get a singleton destination by id
app.get("/destinations/:id", async (req, res) => {
  // Get the city ID from the request parameters
  const destinationId = req.params.id;

  // Find the city in the database
  const city = await destinationsCollection.findOne({ _id: destinationId });

  // If the city does not exist, return a 404 Not Found error response
  if (!city) {
    return res.status(404).json({ message: "City not found" });
  }

  // Send the city back to the client
  res.json(city);
});

// PUT /destinations/:id
app.put("/destinations/:id", async (req, res) => {
  // Get the destination ID from the request parameters
  const destinationId = req.params.id;

  // Get the updated destination data from the request body
  const updateDestination = req.body;

  // Try to update the destination in the database
  const result = await destinationsCollection.updateOne(
    { cityId: destinationId },
    updateDestination
  );

  // If the update was not successful, return a 500 Internal Server Error response
  if (result.modifiedCount === 0) {
    return res.status(500).json({ message: "Failed to update destination" });
  }

  // Return the updated destination to the client
  const updatedDestination = await destinationsCollection.findOne({
    cityId: destinationId,
  });
  res.json(updatedDestination);
});

// DELETE /destinations/:id
app.delete("/destinations/:id", async (req, res) => {
  // Get the destination ID from the request parameters
  const destinationId = req.params.id;

  // Try to delete the place from the database
  const result = await destinationsCollection.deleteOne({
    cityId: destinationId,
  });

  // If the deletion was not successful, return a 500 Internal Server Error response
  if (result.deletedCount === 0) {
    return res.status(500).json({ message: "Failed to delete place" });
  }

  // Return a success response to the client
  res.sendStatus(204);
});

app.listen(port, () => console.log(`listening on http://localhost:${port}`));
