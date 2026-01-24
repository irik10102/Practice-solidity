//SPDX-License-Identifier :MIT

pragma solidity ^0.8.0;

import {PriceConversionLib} from "./PriceConversionLib.sol";

contract FundMe{

    using PriceConversionLib for uint256;
    mapping(address  sender => uint256 value) internal  addressToAmountFunded;

    string internal successString = "Transaction successfull";

    event Success(address from, address to,string successString ,uint256 value);
    event WithdrawlSuccess(address from, address to, string successString, uint256 value);
    

   uint256 constant internal min_usd = 5e18;
   address immutable i_owner = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;                                      
    function fund() public payable{
       
        require(msg.value.priceConversion() >=min_usd, "Send Atleast $5 worth of ETH");
        
        addressToAmountFunded[msg.sender] += msg.value;
        
    }

    function withdraw()public onlyOwner{
       
        (bool res,)=payable(i_owner).call{value:address(this).balance}("");
        require(res, "Withdrawl Failed");
        emit WithdrawlSuccess(msg.sender, i_owner, successString, i_owner.balance);
        
    }

    modifier onlyOwner(){
        require(msg.sender == i_owner, "You are not the owner");
        _;
    }

    receive() external payable {
        fund();
     }

     fallback() external payable { 
        fund();
     }
}