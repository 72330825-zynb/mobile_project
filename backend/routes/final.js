const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

router.get("/:id", async (req, res) => {
  const { id } = req.params;

  try {
    const { data, error } = await supabase
      .from("places")
      .select("*")
      .eq("Place_Id", id)
      .single();

    if (error) {
      console.error(error);
      return res.status(500).json(error);
    }

    if (!data) {
      return res.status(404).json({ message: "Place not found" });
    }

    res.json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json(err);
  }
});

module.exports = router;
