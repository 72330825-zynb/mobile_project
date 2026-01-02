const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

router.get("/", async (req, res) => {
  const { area_id, category_id } = req.query;

  let query = supabase.from("places").select("Place_Id, Image, Title, area_id, category_id");

  if (area_id) query = query.eq("area_id", area_id);
  if (category_id) query = query.eq("category_id", category_id);

  const { data, error } = await query;

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

module.exports = router;