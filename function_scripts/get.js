module.exports = async function (context, req, data) {
  context.res = {
    status: 200,
    body: data,
  };
};
