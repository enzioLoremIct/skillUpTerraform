var request = require("request");

request.get(
  "https://dev-fa-flipendo.azurewebsites.net/api/dev-fn-delete-card-by-id?",
  {
    json: {
      id: "0",
    },
  },
  function (error, response, body) {
    if (!error && response.statusCode == 200) {
      console.log("success");
    } else {
      console.log(response.statusCode);
    }
  }
);
