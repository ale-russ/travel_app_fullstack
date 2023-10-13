var express = require("express");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const jsonwebToken = require("jsonwebtoken");
const MongoClient = require("mongodb").MongoClient;

User = require("./models/user_model");
var routes = require("./api/routes");

dotenv.config();
app = express();
// port = process.env.PORT || 3000;
port = 3001;
routes(app);

const option = {
  socketTimeoutMS: 30000,
  keepAlive: true,
  // reconnectTries: 30000,
};

const mongo_url = process.env.MONGODB_URL;

// const client = new MongoClient(mongo_url);
mongoose.connect(mongo_url).then(
  function () {
    console.log("Mongodb connected successfully");
  },
  function (err) {
    console.log("Error connecting: ", err);
  }
);

app.use(function (req, res, next) {
  if (
    req.headers &&
    req.headers.authorization
    // req.headers.authorization.split(" ")[0] === "JWT"
  ) {
    jsonwebToken.verify(
      req.headers.authorization.split(" ")[1],
      "userAPIS",
      function (err, decode) {
        if (err) req.user = undefined;
        req.user = decode;
        next();
      }
    );
  } else {
    req.user = undefined;
    next();
  }
});

app.use(function (req, res) {
  console.log("Request: ", req.body);
  res.status(404).send({ url: req.originalUrl + " not-found" });
});

app.listen(port);

console.log("RESTful API server start on: " + port);

module.exports = app;
