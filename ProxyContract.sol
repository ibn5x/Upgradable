pragma solidity 0.8.4;

import "./Storage.sol";

contract ProxyCat is Storage {
   //State variable of where our contract will be
    address public currentAddress;
    address owner;
    modifier onlyOwner{
        owner = msg.sender;
        _;
    }
    //set the contract address that the proxy redirect to
    constructor(address _currentAddress) public {
        currentAddress = _currentAddress;
        owner = msg.sender;
    
    }
    
    //upgrade contract address functionalit
    function upgrade(address _currentAddress) public onlyOwner{
        currentAddress = _currentAddress;
    }
    
    //Delegates calls to functional contract address above
    
    function getTheNumber() public returns (bool, bytes memory) {
        /*  
            delagate this call(send request to functional contract address) 
            and to the function we need, and get the data back from that
            call
        
           the delagateCall function is an extrnal call that will call the function
           thats in another contract but will use the state of its own contract
        */
       (bool res, bytes memory data) = currentAddress.delegatecall(abi.encodePacked(bytes4(keccak256("getTheNumber()"))));
       
       return (res, data);
       
       /*
            Breaking it down
            
           1.  abi.encodePacked: (formats the byte string that will contain the data into the correct format)
            
           2.  bytes(): is a casting so that we can convert it into byte format
            
           3. keccak256: is a hashing algorithm for solidity
            
           4. "getTheNumber()": the function we want to call, its in a string
            
            so what are we doing...
            
            we are taking our function name, that has to be a string and hashing it:
                    
                    keccak256("getTheNumber()");
           
           Then we convert/cast that into bytes, so its not a string anymore its a series of bytes
           
                bytes4(keccak256("getTheNumber()");
                    
                    
            then we use the built in solidity function "encodePacked" so that it takes everything and
            puts it into the correct format and structure and  sends it as one single argument
            
                abi.encodePacked(bytes4(keccak256("getTheNumber()")));
                
            the built in encodePacked takes all of the data and puts it in the correct format
            then all of that data is sent as one single arguement to the delegatecall() function which
            will send it to the functional contact which is at the currentAddress.
            
            currentAddress.delegatecall(abi.encodePacked(bytes4(keccak256("getTheNumber()"))));
            
            Now the delgatecall() function returns two things, a boolean that is the result (what this successfull
            or not) which we will store in a variable called res (bool res). and then it returns the actual bytes data (bytes memory data)
            which will be the data that we actaully want to return from the function we're calling .
            it comes back as a hexdecimal 
            
            ( Q: well why are we returning bytes when we know we should be returning an integer?)

            (Answer: thats because the delegatecall function only returns bytes so it will be our number but in hexidecimal form )
            
              
                
     (bool res, bytes memory data) = currentAddress.delegatecall(abi.encodePacked(bytes4(keccak256("getTheNumber()"))));
                
            once we have all that we just return the bytes data
                
            return data;
             
            but we will return both the result and the data for our example 
             
             return (res, data)
       */
    }
    
    function setTheNumber(uint256 _number) public returns (bool, bytes memory) {
        
        (bool res, bytes memory data) = currentAddress.delegatecall(abi.encodePacked(bytes4(keccak256("setTheNumber(uint256)")),_number));
        
        //here we pass the arguements outside of the bytes and withing the abi.encodePacked parenthesis
        
        //we modified the delegatecall() funtion so it knows we expect an arguement((uint)) and then we provided the expected argument (_number)
        return (res, data);
    }
}