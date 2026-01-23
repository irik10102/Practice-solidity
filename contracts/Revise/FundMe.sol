//SPDX-License-Identifier :MIT

pragma solidity ^0.8.0;



contract FundMe{

    mapping(address  sender => uint256 value) public addressToAmountFunded;

    string internal successString = "Transaction successfull";

    event Success(address from, address to,string successString ,uint256 value);
    event WithdrawlSuccess(address from, address to, string successString, uint256 value);
    



    function fund() public payable{
       
        require(msg.value >=5, "Send Atleast $5 worth of ETH");
        
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