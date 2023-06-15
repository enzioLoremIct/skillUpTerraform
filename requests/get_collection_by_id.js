const { request } = require("http");
const http = require("https");

const collection_id = 0;
const url =
  "https://dev-fa-flipendo.azurewebsites.net/api/cards/" + collection_id;

const obj = {
  //id: "0",
  collection_id: "20",
};

const options = {
  method: "GET",
  //{
  //body:
  //json: {
  //  collection_id: "0",
  //},
  //json: JSON.stringify(obj),
  //id: "0",
  //collection_id: "0",
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
