pragma solidity 0.8.4;
/* 
    This is the storage contract, the contract
    that will be inherited by the proxy and functional 
    contract so that they both have the same state variables and
    storage layout so that proxy contract is aware of the layout of the 
    functional contracts state inorder for that contract to handle 
    the writing of variables that come from which ever contract forwarded 
    the request
*/

contract Storage {
    
    uint256 number;
    
    function getNumber() internal view returns(uint256){
        return number;
        
    }
    
    function setNumber(uint256 _number) internal {
        number = _number;
    }
}
