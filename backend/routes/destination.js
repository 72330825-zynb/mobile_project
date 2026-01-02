const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

// Supabase client
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

/*
 GET /destinations
 بيرجع Destination واحد (Featured)
 */
router.get("/", async (req, res) => {
  const { data, error } = await supabase
    .from("destinations")
    .select("Destinations_Id, Name, Image, Details");
 

  if (error) {
    console.error(error);
    return res.status(500).json({ error: error.message });
  }

  res.json(data);
});

module.exports = router;