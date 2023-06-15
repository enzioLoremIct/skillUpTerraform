const cosmos = require("@azure/cosmos");
const connection = process.env.COSMOS_DATABASE_CONNECTION;
const tmp = connection.split;
const endpoint = tmp[0];
const key = tmp[1];
const { CosmosClient } = cosmos;

const client = new CosmosClient({ endpoint, key });
const container = client.database("flipendo-database").container("Items");

module.exports = async function (context) {
  const { id } = context.req.body;
  const _id = { id };
  const item = container.item(_id);
  await item.delete();
};
