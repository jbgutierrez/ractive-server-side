express = require('express')
router = express.Router()

router.get '/:engine', (req, res, next) ->
  engine = req.params.engine
  console.log engine
  list = (name: i for i in [1..10000])
  res.render "index.#{engine}", list: list

module.exports = router
