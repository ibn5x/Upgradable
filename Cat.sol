pragma solidity 0.8.4;


import "./Storage.sol";

contract Cat is Storage {
   
    
    function getTheNumber() public view returns(uint256){
        return Storage.getNumber();
    } 
    
    function setTheNumber(uint256 toSet)public {
         Storage.setNumber(toSet);
    }
}

