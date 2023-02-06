const { expect } = require("chai");
const { ethers } = require("hardhat");
import type { EngAuction } from "../typechain-types";

describe("EngAuction", async function(){
    let owner
    let bid1
    let bid2
    const itenName = "huawei"
    const minPrice = 10000000000000000
    const enoughPrice = 5000000000000000000

    beforeEach("EngAuction", async function(){
        [owner, bid1, bid2] = await ethers.getSigners()
        const EngAuction = await ethers.getContractFactory("EngAuction", owner)
        const auction: EngAuction = await EngAuction.deploy(itenName, minPrice, enoughPrice)
        await auction.deployed()
    });

    it("should be deployed", async function(){
        expect (auction.address).to.be.properAddress
    })
});  