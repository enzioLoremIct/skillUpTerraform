var request = require("request");

request.post(
  "https://dev-fa-flipendo-2f25.azurewebsites.net/api/dev-fn-insert?",
  {
    json: {
      id: "112341234",
      collection_id: "1234567890",
      name: "Cat",
      translation: "Katze",
    },
  },
  function (error, response, body) {
    if (!error && response.statusCode == 201) {
      console.log(body);
    } else {
      console.log(response.statusCode);
      //console.log(response);
    }
  }
);
