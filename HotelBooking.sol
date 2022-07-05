// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HotelManagement{
    
    uint roomId = 201;
    address owner;

    constructor(){
        owner=msg.sender;
    }

    modifier isOwner{
        require(msg.sender == owner ,"Not Aurthorised");
        _;
    }

    event booked(string _name, uint _phNumber, uint _noOfDays, uint _time,bool _status);

    struct Visitor{
        string name;
        uint phNumber;
        uint noOfDays;
        uint time;
        bool status;
    }

    mapping (uint => Visitor) visitors;
    
    function bookRoom(string memory _name, uint _phNumber, uint _noOfDays) public payable{
        require(msg.value >= _noOfDays*1 ether,"insufficient balance");
        visitors[roomId] = Visitor(_name, _phNumber, _noOfDays, block.timestamp, true);
        roomId++;
        if(msg.value-_noOfDays*1 ether> 0){
            payable(msg.sender).transfer(msg.value-_noOfDays*1 ether);
        }
        emit booked(_name,_phNumber,_noOfDays,block.timestamp,true);
    }

    function roomStatus(uint _roomId) public view isOwner returns(Visitor memory){
            return visitors[_roomId];
    }
}