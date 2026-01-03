const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// POST /login
router.post('/', async (req, res) => {
  const { name, password } = req.body;

  if (!name || !password) {
    return res.status(400).json({
      success: false,
      message: 'Missing name or password',
    });
  }

  try {
    // نستعلم عن الuser بالname و password
    const { data, error } = await supabase
      .from('users')   // table اسمها users
      .select('*')
      .eq('name', name)
      .eq('password', password);

    if (error) throw error;

    if (data.length > 0) {
      res.json({
        success: true,
        user: {
          id: data[0].id,
          name: data[0].name,
        },
      });
    } else {
      res.status(401).json({
        success: false,
        message: 'Invalid name or password',
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      message: 'Supabase error',
      error: err.message,
    });
  }
});

module.exports = router;