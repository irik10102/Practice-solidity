//SPDX-License-Identifier: MIT


pragma solidity ^0.8.1;
import {PriceConversionLib} from './PriceConversionLib.sol';

contract FundMe{
    using PriceConversionLib for uint256;

    uint min_usd = 5e18;                               //$5
    function fund() public payable{
        require(msg.value.getConversionRate()>=min_usd, "Send Atleast 5 usd worth of eth");
        
    }

    function withdraw() public{}

   
}
