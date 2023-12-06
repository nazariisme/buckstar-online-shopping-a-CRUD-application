"use strict";
/**
  * Author Ali Nazari
  * The routes for moving money between Adam and Eva on the client side.
*/

const express = require('./../node_modules/express');
const router = express.Router();
const db = require('./../src/helpers.js');
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

router.get("/eshop/index", (reg, res) => {
    let data = {};

    data.title = "Hem";
    res.render("pages/index.ejs", data);
});

router.get("/eshop/products", async (reg, res) => {
    let data = {};

    data.title = "Produkter";
    let result  = await db.showProduct();

    data.showProducts = result[0];

    res.render("pages/products.ejs", data);
});

router.get("/eshop/category", urlencodedParser, async (reg, res) => {
    let data = {};

    data.title = "Produktkatogorier";
    let result = await db.showCategory();

    data.showCategory =result[0];
    res.render("pages/category.ejs", data);
});

router.get("/eshop/add-product", async (reg, res) => {
    let data = {};

    data.title = "Add product";
    res.render("pages/addproduct.ejs", data);
});

router.post("/eshop/add-product", async (reg, res) => {
    await db.addProduct(reg.body);
    res.redirect("/eshop/products");
});

router.get("/eshop/about", async (reg, res) => {
    let data = {};

    data.title = "Om";
    res.render("pages/about.ejs", data);
});

router.get("/eshop/category", (reg, res) => {
    let data = {};

    data.title = "Balance";
    res.render("pages/move-to-adam.ejs", data);
});

router.get("/eshop/update/:produktkod", async (reg, res) => {
    let data = {};

    data.title = "Updatera produkt";
    data.product = await db.getProduct(reg.params.produktkod);

    res.render("pages/update.ejs", data);
});

router.post("/eshop/update/:produktkod", async (reg, res) => {
    await db.updateProduct(reg.body);
    res.redirect("/eshop/products");
});

router.get("/eshop/delete/:produktkod", async (reg, res) => {
    let data = {};

    data.title = "Radera produkt";
    data.product = await db.getProduct(reg.params.produktkod);

    res.render("pages/delete.ejs", data);
});

router.post("/eshop/delete/:produktkod", async (reg, res) => {
    await db.deleteProduct(reg.body);
    res.redirect("/eshop/products");
});

router.get("/eshop/customer", async (reg, res) => {
    let data = {};
    let result = await db.showCustomer();

    data.title = "Kunder";
    data.showCustomer = result;

    res.render("pages/customer.ejs", data);
});

router.get("/eshop/order", async (reg, res) => {
    let data = {};
    let result = await db.showOrder();

    data.title = "Order";
    data.showOrder = result[0];

    res.render("pages/order.ejs", data);
});

router.get("/eshop/order-manager/:ID", async (reg, res) => {
    let data = {};

    data.title = "Order Hanterare";
    data.showCustomer = await db.createOrder(reg.params.ID);

    res.redirect("/eshop/order");
});


router.get("/eshop/choose-products/:orderid/:kundid", async (reg, res) => {
    let data = {};

    data.title = "Valja Produkter";
    let result  = await db.showProduct();

    data.showProducts = result[0];

    res.render("pages/choose-products.ejs", data);
});

router.post("/eshop/choose-products/:orderid/:kundid", async (reg, res) => {
    let orderid = reg.params.orderid;
    let kundid = reg.params.kundid;
    let produktkod = reg.body.p_produktkod;
    let antal = reg.body.p_antal;
    let tempAntal;
    let tempProduktkod;

    for (var i = 0; i < antal.length; i++) {
        if (antal[i] != '') {
            tempProduktkod = produktkod[i];
            tempAntal = antal[i];
            await db.insertProdukt(tempProduktkod, kundid, orderid, tempAntal);
            await db.updateLager(tempAntal, tempProduktkod);
        } else {
            continue;
        }
    }

    await db.updateOrder(orderid, kundid);
    res.redirect("/eshop/order");
});

router.get("/eshop/show-order/:orderid", async (reg, res) => {
    let data = {};

    data.title = "Visa Order";
    data.orderid = reg.params.orderid;
    data.orderInformation = await db.showAOrder(data.orderid);
    let customerId = await db.getCustomerId(data.orderid);
    let orderStatus = await db.getAOrderStatus(data.orderid);

    for (const row of customerId) {
        data.kundId = row.kundid;
    }

    for (const row of orderStatus) {
        data.orderStatus = row.status;
    }

    data.kundInformation = await db.getACustomer(data.kundId);
    res.render("pages/show-order.ejs", data);
});

module.exports = router;
