// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract StakingContract {
    mapping(address => uint) public stakes;
    mapping(address => uint) public rewards;
    
    function stake(uint amount) public {
        require(amount > 0, "Amount cannot be zero");
        require(stakes[msg.sender] == 0, "You have already staked");
        stakes[msg.sender] = amount;
    }
    
    function unstake() public{
        require(stakes[msg.sender] > 0, "You have not staked yet");
        payable(msg.sender).transfer(stakes[msg.sender] + rewards[msg.sender]);
        rewards[msg.sender] = 0;
        stakes[msg.sender] = 0;
    }
    
    function earnReward() public {
        require(stakes[msg.sender] > 0, "You have not staked yet");
        rewards[msg.sender] += stakes[msg.sender] * 5 / 100; //5% annual return
    }
}