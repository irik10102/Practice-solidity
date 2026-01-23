//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConversionLib{

    function getPriceFeed()internal view returns(uint256){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x38cB7800C3Fddb8dda074C1c650A155154924C73);

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