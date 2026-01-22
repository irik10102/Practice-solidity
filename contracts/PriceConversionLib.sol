//SPDX-License-Identifier:MIT

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

pragma solidity ^0.8.0;

library PriceConversionLib{
    

     function getPrice()  internal view returns(uint256){
        AggregatorV3Interface priceFeed =   AggregatorV3Interface(0x0fC5025C764cE34df352757e82f7B5c4Df39A836);
         (,int256 ETH_in_USD,,,) = priceFeed.latestRoundData();

       
          return uint256(ETH_in_USD*1e10);
    }

    function getConversionRate(uint256 eth_amt) internal view returns(uint256){
        uint256 ETHUSDrate = getPrice();                     
        
        return (ETHUSDrate*eth_amt)/1e18;                 //((Price*1e18)*eth_amt)/1e18 -> eth_amt is in wei
    }
    
}