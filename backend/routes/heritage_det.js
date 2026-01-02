const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

router.get("/", async (req, res) => {
  const { heritage_id } = req.query;

  if (!heritage_id) return res.status(400).json({ error: "heritage_id required" });

  const { data, error } = await supabase
    .from("heritage")
    .select(
      "Heritage_Id, Heritage_Title, Story, Cost, Weather, Main_Image, area_id, category_id"
    )
    .eq("Heritage_Id", heritage_id);

  if (error) return res.status(500).json({ error: error.message });

  res.json(data); // نرجع array مباشر
});

module.exports = router;
