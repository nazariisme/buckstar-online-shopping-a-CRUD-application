"use strict";
/**
 * Help functions for displaying the menu and exiting the program.
 * Author Ali Nazari
 */

let helpFunctions;

helpFunctions = {

    //Function for exiting the program
    exitProgram: function(code) {
        code = code || 0;

        console.log("Exiting program with code: "+ code);
        process.exit(0);
    },

    //Fucntion for showing the menu
    showMenu: function() {
        console.log(`
        Available commands:

        1: exit                                     - Closes the program
        2: menu                                     - Displays the menu
        3: about                                    - Group members
        4: inv                                      - Displays the stock information of the products
        5: shelf                                    - Displays the name of the stock shelfs
        6: product                                  - Displays the available products
        7: inv <str>                                - Filters the stock information
        8: log <number>                             - Displays the latest changes in the inventory
        9: invadd <productid> <shelf> <number>      - Adds a product to a specified shelf
        10: invdel <productid> <shelf> <number>     - Deletes a product from a specified shelf
        11: order                                   - Displays all the orders
        12: order <search>             - Displays and filters the orders by orderid or kundid
        13: plocklista <orderid>       - Creates a pick list for a choosen order
        14: ship <orderid>             - Changes the status of a choosen order to Skickad
        `);
    }
};

module.exports = helpFunctions;
