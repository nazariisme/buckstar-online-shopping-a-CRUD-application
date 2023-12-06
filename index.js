/**
  * Author Ali Nazari
  * The client interface for moving money between Adam and Eva on the client side.
*/

const express = require('./node_modules/express');
const port = 1337;
const indexRoutes = require('./routes/index-routes.js');
const app = express();

app.set("view engine", "ejs");
app.use(express.urlencoded({extended: true}));
app.use(express.static("public"));

app.use((req, res, next) => {
    console.log(`Got a request on ${req.path} with ${req.method}`);
    next();
});

app.use("/", indexRoutes);

app.listen(port, () => {
    console.log(`Serve is listening on port ${port}`);
});
