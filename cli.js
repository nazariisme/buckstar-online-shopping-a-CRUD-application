"use strict";

const helpers = require('./src/helpers.js');
const helpFunctions = require('./src/helpFunctionsCli.js');
const table = require('console.table');
const readline = require('readline');

const rl = readline.createInterface ( {
    input: process.stdin,
    output: process.stdout
});

(async function() {
    table;
    rl.setPrompt(">> ");
    rl.prompt();

    rl.on('line', async (input) => {
        input = input.trim();
        let inputParts = input.split(" ");

        switch (inputParts[0]) {
            case 'exit': {
                helpFunctions.exitProgram();
                break;
            }
            case 'menu': {
                helpFunctions.showMenu();
                break;
            }
            case 'about': {
                console.log(`Ali Reza Nazari`);
                break;
            }
            case 'log': {
                let result = await helpers.showLog(inputParts[1]);

                console.table(result);
                break;
            }
            case 'product': {
                let result = await helpers.product();

                console.table(result);
                break;
            }
            case 'shelf': {
                let result = await helpers.shelf();

                console.table(result);
                break;
            }
            case 'inv': {
                if (inputParts.length === 1) {
                    let result = await helpers.inv();

                    console.table(result);
                    break;
                } else {
                    let result;

                    if (Number.isInteger(parseInt(inputParts[1])) === false) {
                        result = await helpers.invStr(inputParts[1]);
                    } else if (Number.isInteger(parseInt(inputParts[1])) === true) {
                        result = await helpers.invInt(inputParts[1]);
                    }

                    console.table(result);
                    break;
                }
            }
            case 'invadd': {
                await helpers.invadd(inputParts[1], inputParts[2], inputParts[3]);
                break;
            }
            case 'invdel': {
                await helpers.invdel(inputParts[1], inputParts[2], inputParts[3]);
                break;
            }
            case 'order': {
                if (inputParts.length === 1) {
                    let result = await helpers.showOrderTerminal();

                    console.table(result[0]);
                    break;
                } else {
                    let result = await helpers.showAOrderTerminal(inputParts[1]);

                    console.table(result);
                    break;
                }
            }
            case 'picklist': {
                let result = await helpers.createPlocklist(inputParts[1]);

                console.table(result);
                console.info(`Varan finns alltid i lager eftersom det går inte att betälla det via 
webbklilenten om det är slut, dvs det visas där om det finns i lager eller inte.`);
                break;
            }
            case 'ship': {
                await helpers.shipOrder(inputParts[1]);
                break;
            }
        }
        rl.prompt();
    });
})();
