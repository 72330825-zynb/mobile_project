const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

router.get("/", async (req, res) => {
  const { data, error } = await supabase
    .from("areas")
    .select("area_id, area_name")
    .order("area_id");

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

module.exports = router;