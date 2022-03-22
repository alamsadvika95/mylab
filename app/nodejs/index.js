const express = require("express");
const app = express();
// const mongoose = require("mongoose");
// const dotenv = require("dotenv");
// const userRoute = require("./routes/user");
// const authRoute = require("./routes/auth");
// const productRoute = require("./routes/product");
// const orderRoute = require("./routes/order");
// const cartRoute = require("./routes/cart");
// const stripeRoute = require("./routes/stripe");
// const cors = require("cors");
//coba node-test
const bodyParser = require('body-parser');
const multer = require('multer');
const db = require("./config/db");
const User = require("./config/User");

//Configuration for .env
dotenv.config();

// //Connect to MongoDB
// mongoose.connect(
//   process.env.MONGO_URI)
//   .then(() => console.log("DBConnection Successful"))
//   .catch((err) => {
//       console.log(err);
//   });

// //Cors
// app.use(cors());
// //Routes
// app.use(express.json());
// app.use("/api/auth", authRoute);
// app.use("/api/users", userRoute);
// app.use("/api/products", productRoute);
// app.use("/api/orders", orderRoute);
// app.use("/api/carts", cartRoute);
// app.use("/api/checkout", stripeRoute);
app.get('/', (req, res) => {
  res.send('Hello World');
});

//Configuration for Port 
app.listen(process.env.PORT, () => {
  console.log( `Backend server is running on port ${process.env.PORT}`);
});


//-----------------------------------------------------------------------------------------------------------------
//NODE JS TESTING


db.authenticate().then(() =>
  console.log("berhasil terkoneksi dengan database")
);

// Create File Storage
const fileStorage = multer.diskStorage({
  destination: (req, file, cb) => {
      cb(null, '/mnt/images');
  },
  filename: (req, file, cb) => {
      cb(null, new Date().getTime() + '-' + file.originalname)
  }
})

//Create filter image yang akan diupload
const fileFilter = (req, file, cb) => {
  if(
      file.mimetype === 'image/png' || 
      file.mimetype === 'image/jpg' || 
      file.mimetype === 'image/jpeg'
  ){
      cb(null, true);
  } else {
      cb(null, false);
  }
} 

//upload image
app.use(multer({storage: fileStorage, fileFilter: fileFilter}).single('image'))
app.use(bodyParser.json());

//api routes
app.post("/crud", async (req, res) => {
  try {
    // destructuring object
    const username = req.body.username;
    const email = req.body.email;
    const image = req.file.path;

    // initialize models database 
    const newUser = new User({
      username,
      email,
      image
    }); 

    // await = menjalankan kode models user
    await newUser.save();

    // menampilkan newuser ketika di save postman 
    res.json(newUser);
  } catch (err) {
    console.error(err.message);
    res.status(500).send("server error");
  }
});






