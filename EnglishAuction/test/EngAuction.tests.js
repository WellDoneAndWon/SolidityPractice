const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EngAuction", async function(){
    let ownerSeller
    let buyer1
    let buyer2
    const itemName = "pc"
    const minPrice = 10000000000000000
    const enoughPrice = 5000000000000000000

    beforeEach("EngAuction", async function(){
        [ownerSeller, buyer1, buyer2] = await ethers.getSigners()
        const EngAuction = await ethers.getContractFactory("EngAuction")
        const auction: EngAuction = await EngAuction.deploy(itemName, minPrice, enoughPrice)
        await auction.deployed()
    });

    it("should be deployed", async function(){
        expect (auction.address).to.be.properAddress
    })
});  