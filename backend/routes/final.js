const express = require("express");
const router = express.Router();
const db = require("../connection");

router.get("/:id", (req, res) => {
  const { id } = req.params;

  const sql = "SELECT * FROM places WHERE Place_Id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) return res.status(500).json(err);
    if (result.length === 0)
      return res.status(404).json({ message: "Place not found" });

    res.json(result[0]);
  });
});

module.exports = router;
