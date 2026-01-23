//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConversionLib{

    function getPriceFeed()internal view returns(uint256){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0xb27A31f1b0AF2946B7F582768f03239b1eC07c2c);

        ( ,int256 price, , ,  ) = pricefeed.latestRoundData();
        return uint256(price*1e10);
    }

    function priceConversion(uint256 eth_amt) internal  view returns(uint256){

        //Assuming eth_amt is already scaled with "number*1e18" format

        uint256 price = getPriceFeed();
        uint256 eth_price = (eth_amt*price)/(1e18);
        return eth_price;
    }
}