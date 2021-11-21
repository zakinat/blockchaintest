// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Donation {
  address payable public owner;
  address[] public donators;
  uint[] public values;
  modifier onlyOwener(){
    require(owner==payable(msg.sender),"Not allowed");
    _;
  }
    constructor() public {
    owner=payable(msg.sender);
  }

  function gatherDonation() public payable {
    require(msg.value>=.001 ether);
    donators.push(msg.sender);
    values.push(msg.value/(1e18));//msg value return wei, that is ether=1e18 wei
      }

  function transferToOwner() external {
    require(payable(msg.sender)==owner);
    owner.transfer(address(this).balance);
  }

  function getDonators() public view returns (address[] memory){
    return donators;
  }

  function getValues() public view returns (uint[] memory){
    return values;
  }

  function getDonaterValues() public view returns (address[] memory,uint[] memory){
    return (donators,values);
  }
}
