const express = require("express");
require("dotenv").config();
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// Routes
const areasRouter = require("./routes/areas");
const categoriesRouter = require("./routes/categories");
const placesRouter = require("./routes/places");
const destinationRoute = require("./routes/destination");
const heritageRouter = require("./routes/heritage")


// server.js
app.get("/test", (req, res) => {
  res.send("🚀 Mobile Project API is running! Use /items, /places, /heritage, /destination");
});

app.use("/items", areasRouter);
app.use("/categories", categoriesRouter);
app.use("/places", placesRouter);
app.use("/destination" , destinationRoute);
app.use("/heritage" , heritageRouter);




const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
