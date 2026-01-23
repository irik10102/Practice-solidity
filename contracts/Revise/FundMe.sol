//SPDX-License-Identifier :MIT

pragma solidity ^0.8.0;

import {PriceConversionLib} from "./PriceConversionLib.sol";

contract FundMe{

    using PriceConversionLib for uint256;
    mapping(address  sender => uint256 value) internal  addressToAmountFunded;

    string internal successString = "Transaction successfull";

    event Success(address from, address to,string successString ,uint256 value);
    event WithdrawlSuccess(address from, address to, string successString, uint256 value);
    

   uint256 internal min_usd = 5e18;

    function fund() public payable{
       
        require(msg.value.priceConversion() >=min_usd, "Send Atleast $5 worth of ETH");
        
        addressToAmountFunded[msg.sender] += msg.value;
        
    }

    function withdraw(uint256 withdAmt)public {
        uint256 amtFunded = addressToAmountFunded[msg.sender];
        address senderAddress = msg.sender;

        require(amtFunded>=withdAmt, "You do not have enough funds to withdraw");

        (bool result,) = payable(senderAddress).call{value:withdAmt}('');
        require(result, "Transaction Failure");
        emit WithdrawlSuccess(address(this), senderAddress, successString, withdAmt);
        addressToAmountFunded[senderAddress] = 0;

        
    }
}