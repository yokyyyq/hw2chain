// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract StorageContract {
    struct MyData {
        uint256 number;
        string name;
        address owner;
        bool isDeleted;
    }

    mapping(uint256 => MyData) myDataMap;

    function addData(uint256 key, uint256 _number, string memory _name) external {
        require(myDataMap[key].isDeleted == false, "Data with this key already exists");
        
        MyData memory newData = MyData({
            number: _number,
            name: _name,
            owner: msg.sender,
            isDeleted: false
        });

        myDataMap[key] = newData;

        emit DataAdded(key, newData.number, newData.name, newData.owner);
    }

    function removeData(uint256 key) external {
        require(myDataMap[key].isDeleted == false, "Data with this key doesn't exist");

        myDataMap[key].isDeleted = true;

        emit DataRemoved(key, myDataMap[key].number, myDataMap[key].name, myDataMap[key].owner);
    }

    event DataAdded(uint256 key, uint256 number, string name, address owner);
    event DataRemoved(uint256 key, uint256 number, string name, address owner);
}