const express = require('express')
const bodyParser = require('body-parser')

const app = express()
const port = 3000

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', (request, response) => {

    var request_number = request.query.request_number,
        range = Array.from({length: parseInt(request_number)}),
        response_array = Array.from({length: 0})
    
    for (const interator in range) {

      var range2 = Array.from({length: interator})
      
      for (const interator2 in range2) {

        var range3 = Array.from({length: interator2})

        for (const interator3 in range3) {

          let interator_calc = ((Math.floor(Math.random() * interator) + 1) * (Math.floor(Math.random() * interator2) + 1) * (Math.floor(Math.random() * interator3) + 1) * request_number)
          response_array.push(interator_calc)
        }
      }  
    }

    let result = (response_array).reduce(function(total, num){ total += (num || 1); return total; }, 0);
    
    response.json({ info: result })
})

app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})