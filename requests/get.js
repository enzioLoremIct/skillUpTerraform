const http = require("https");

const url = "https://dev-fa-flipendo-2f25.azurewebsites.net/api/dev-fn-get?"; //"https://bratschie20232.azurewebsites.net/api/get?";

const options = {
  method: "GET",
};

let result = "";
const req = http.request(url, options, (res) => {
  console.log(res.statusCode);

  res.setEncoding("utf8");
  res.on("data", (chunk) => {
    result += chunk;
  });

  res.on("end", () => {
    console.log(result);
  });
});

req.on("error", (e) => {
  console.error(e);
});

req.end();
