const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");


const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);


// GET heritage details by id
router.get("/:id", async (req, res) => {
  const { id } = req.params;

  const { data, error } = await supabase
    .from("heritage")
    .select(
      `
      Heritage_id,
      Heritage_Title,
      Story,
      Cost,
      Weather,
      Main_Image
      `
    )
    .eq("Heritage_id", id)
    .single();

  if (error) {
    return res.status(400).json({ error: error.message });
  }

  res.json(data);
});

module.exports = router;