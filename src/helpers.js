"use strict";

const mysql = require('promise-mysql');
const config = require('./../config/db/eshop.json');
let helpers;

helpers = {
    showCategory: async function() {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL show_category();`;
        let res = await db.query(sql);

        db.end();
        return res;
    },
    showProduct: async function() {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL show_product();`;
        let res = await db.query(sql);

        db.end();
        return res;
    },
    addProduct: async function(data) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL insert_product(?, ?, ${data.p_pris});`;

        let res = await db.query(sql, [data.p_namn, data.p_beskrivning]);

        db.end();
        return res;
    },
    getProduct: async function(produktkod) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL get_product(${produktkod});`;
        let res = await db.query(sql);

        db.end();
        return res[0];
    },
    updateProduct: async function(data) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL update_product(${data.p_produktkod}, ?, ?, ?);`;
        let res = await db.query(sql, [data.p_namn, data.p_beskrivning, data.p_pris]);

        db.end();
        return res;
    },
    deleteProduct: async function(data) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL delete_product(${data.p_produktkod});`;
        let res = await db.query(sql);

        db.end();
        return res;
    },
    showLog: async function(number) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL log_number(${number});`;
        let res = await db.query(sql);

        db.end();
        return res[0];
    },
    product: async function() {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL product();`;
        let res = await db.query(sql);

        db.end();
        return res[0];
    },
    shelf: async function() {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL shelf();`;
        let res = await db.query(sql);

        db.end();
        return res[0];
    },
    inv: async function() {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL inv();`;
        let res = await db.query(sql);

        db.end();
        return res[0];
    },
    invInt: async function(input) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL inv_str(?);`;
        res = await db.query(sql, [input]);

        db.end();
        return res[0];
    },
    invStr: async function(input) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL inv_str(?);`;
        res = await db.query(sql, [`%${input}%`]);

        db.end();
        return res[0];
    },
    invadd: async function(pkod, pantal, phylla) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL invadd(?, ?, ?);`;
        await db.query(sql, [pkod, pantal, phylla]);

        db.end();
    },
    invdel: async function(pkod, pantal, phylla) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL invdel(?, ?, ?);`;
        await db.query(sql, [pkod, pantal, phylla]);

        db.end();
    },
    showCustomer: async function() {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL show_customer();`;
        res = await db.query(sql);

        db.end();
        return res[0];
    },
    createOrder: async function(kundid) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL create_order(${kundid});`;
        await db.query(sql);

        db.end();
    },
    showOrder: async function() {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL show_order();`;
        let res = await db.query(sql);

        db.end();
        return res;
    },
    insertProdukt: async function(produktkod, kundid, orderid, antal) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL insert_product(?, ?, ?, ?);`;
        await db.query(sql, [produktkod, kundid, orderid, antal]);

        db.end();
    },
    updateOrder: async function(orderid, kundid) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL update_order(?, ?);`;
        await db.query(sql, [orderid, kundid]);

        db.end();
    },
    showAOrder: async function(orderid) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL show_a_order(?);`;
        res = await db.query(sql, [orderid]);

        db.end();
        return res[0];
    },
    getACustomer: async function(kundid) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL get_customer(?);`;
        res = await db.query(sql, [kundid]);

        db.end();
        return res[0];
    },
    getCustomerId: async function(orderid) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL get_kund_id(?);`;
        res = await db.query(sql, [orderid]);

        db.end();
        return res[0];
    },
    getAOrderStatus: async function(orderid) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL get_order_status(?);`;
        res = await db.query(sql, [orderid]);

        db.end();
        return res[0];
    },
    updateLager: async function(antal, produktkod) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL uppdate_lager_status(?, ?);`;
        await db.query(sql, [antal, produktkod]);

        db.end();
    },
    showOrderTerminal: async function() {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL show_order_terminal();`;
        let res = await db.query(sql);

        db.end();
        return res;
    },
    showAOrderTerminal: async function(orderid) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL show_a_order_terminal(?);`;
        res = await db.query(sql, [orderid]);

        db.end();
        return res[0];
    },
    createPlocklist: async function(orderid) {
        const db = await mysql.createConnection(config);
        let sql;
        let res;

        sql = `CALL create_plocklist(?);`;
        res = await db.query(sql, [orderid]);

        db.end();
        return res[0];
    },
    shipOrder: async function(orderid) {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `CALL ship_order(?);`;
        await db.query(sql, [orderid]);

        db.end();
    }
};
module.exports = helpers;
