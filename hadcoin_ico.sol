pragma solidity^0.8.21;

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

    function equity_in_hadcoins(address investor) external constant returns (uint) {
        return equity_hadcoins[address];
    }

    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_hadcoins[address];
    }
}