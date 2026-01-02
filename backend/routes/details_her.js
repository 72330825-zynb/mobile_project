import express from "express";
import supabase from "../supabaseClient.js";

const router = express.Router();

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

export default router;