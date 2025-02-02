pragma solidity ^0.8.21;

contract hadcoin_ico {
    // ICO info 
    uint public max_hadcoins = 1000000;

    uint public usd_to_hadcoins = 1000;

    uint public total_hadcoint_bought = 0;

    mapping (address => uint) equity_hadcoins;
    mapping (address => uint) equity_usd;

    modifier can_buy_hadcoin(uint usd_invested) {
        require(usd_invested * usd_to_hadcoins + total_hadcoint_bought <= max_hadcoins);
        _;
    }

    function equity_in_hadcoins(address investor) external view returns (uint) {
        return equity_hadcoins[investor];
    }

    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    function buy_hadcoin(address investor, uint usd_investor) external 
    can_buy_hadcoin(usd_investor) {
        uint hadcoun_bought = usd_investor * usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoun_bought;
        equity_usd[investor] += equity_hadcoins[investor] / 1000;
        total_hadcoint_bought += hadcoun_bought;
    }

   function sell_hadcoin(address investor, uint sold_hadcoins) external {
        equity_hadcoins[investor] -= sold_hadcoins;
        equity_usd[investor] += equity_hadcoins[investor] / 1000;
        total_hadcoint_bought -= sold_hadcoins;
   }
}