module.exports = async function (context, req) {
  const {
    collection_id,
    id,
    card_position,
    name,
    translation,
    description,
    translated_description,
    image,
  } = req.body;
  const item = {
    collection_id,
    id,
    card_position,
    name,
    translation,
    description,
    translated_description,
    image,
  };

  context.bindings.data = JSON.stringify(item);

  context.res = {
    status: 201,
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(item),
  };
};
