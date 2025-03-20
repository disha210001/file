// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AIModelTracker {
    // Struct to store AI model data
    struct AIRecord {
        uint256 id;
        string modelName;
        string inputData;
        string outputData;
        address user;
        uint256 timestamp;
    }

    // Array to store all AI records
    AIRecord[] public records;

    // Mapping to track user contributions
    mapping(address => uint256) public userContributions;

    // Event to emit when a new AI record is added
    event AIRecordAdded(uint256 id, string modelName, address indexed user, uint256 timestamp);

    // Function to add a new AI record
    function addAIRecord(string memory _modelName, string memory _inputData, string memory _outputData) public {
        uint256 recordId = records.length;

        records.push(AIRecord({
            id: recordId,
            modelName: _modelName,
            inputData: _inputData,
            outputData: _outputData,
            user: msg.sender,
            timestamp: block.timestamp
        }));

        userContributions[msg.sender]++;

        emit AIRecordAdded(recordId, _modelName, msg.sender, block.timestamp);
    }

    // Function to get total records
    function getTotalRecords() public view returns (uint256) {
        return records.length;
    }

    // Function to retrieve an AI record by ID
    function getAIRecord(uint256 _id) public view returns (AIRecord memory) {
        require(_id < records.length, "Record does not exist");
        return records[_id];
    }

    // Function to get a user's contribution count
    function getUserContributions(address _user) public view returns (uint256) {
        return userContributions[_user];
    }
} 
