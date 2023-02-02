// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TicketMachineV2 is Initializable {
    address public owner;
    uint public ticketsAvailable;
    uint public ticketId;

    mapping(address => bool) public ticketPurchased;

    event Purchase(address indexed buyer, uint timeOfPurchase, uint ticketId);

    function initialize(uint _ticketsAvailable) public initializer{
        ticketsAvailable = _ticketsAvailable;
        owner = msg.sender;
        ticketId = 0;
    }

    function buyTicket() public payable {
        require(msg.value >= 0.1 ether, "Amount insufficient, a ticket costs 0.1 ether");
        ticketsAvailable--;
        ticketPurchased[msg.sender] = true;
        ticketId++;
        emit Purchase(msg.sender, block.timestamp, ticketId);
    }

    function withdrawFunds() public onlyOwner {
        require(address(this).balance > 0, "Nothing to withdraw");
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Withdrawal attempt failed");
    }

    function setNewOwner(address payable _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

}