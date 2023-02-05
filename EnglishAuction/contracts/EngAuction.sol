// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract EngAuction {
    address public owner;
    mapping(address => uint) public bids;
    enum ItemStatus {Nonexistent, Sellable, Sold}
    ItemStatus public currentStatus;
    Item public newItem;
    address lastBuyer;
    uint lastValue;

    constructor(string memory _itemName, uint _minPrice, uint _enoughPrice) {
        owner = msg.sender;
        Item memory _newItem = Item(
            _itemName,
            _minPrice,
            _enoughPrice,
            msg.sender,
            currentStatus = ItemStatus.Sellable,
            address(0x0)
        );
        newItem = _newItem;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner!");
        _;
    }

    modifier onlyDepositor() {
        require(bids[msg.sender] != bids[address(0x0)], "You're not the owner!");
        _;
    }

    struct Item {
        string itemName;
        uint minPrice;
        uint enoughPrice;
        address authorAddress;
        ItemStatus currentStatus;
        address buyer;
    }

    function bet() public payable {
        require((msg.value >= newItem.minPrice) && (currentStatus != ItemStatus.Sold) && (lastValue < msg.value), "This is less than the previous bid!");
        if(newItem.enoughPrice <= msg.value) {
            currentStatus = ItemStatus.Sold;
            bids[newItem.buyer = msg.sender] -= msg.value;
            payable(owner).transfer(msg.value);
        }
        lastBuyer = msg.sender;
        lastValue = msg.value;
        bids[msg.sender] += msg.value;
    }
 
    function stop() external onlyOwner() {
        currentStatus = ItemStatus.Sold;
        bids[lastBuyer] -= lastValue;
        payable(owner).transfer(lastValue);
    }

    function giveBack() external onlyDepositor() {
        payable(msg.sender).transfer(bids[msg.sender]);
        bids[msg.sender] = 0;
    }
}
