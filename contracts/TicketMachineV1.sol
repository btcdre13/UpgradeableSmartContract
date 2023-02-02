// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TicketMachineV1 is Initializable {
    address public owner;
    uint public ticketsAvailable;

    function initialize(uint _ticketsAvailable) public initializer {
        ticketsAvailable = _ticketsAvailable;
        owner = msg.sender;
    }

    function purchaseTicket() public payable {
        require(msg.value >= 0.1 ether, "Amount insufficient, a ticket costs 0.1 ether");
        ticketsAvailable--;
    }
}