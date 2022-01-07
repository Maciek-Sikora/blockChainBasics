// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

// importuje z chainlinka
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FoundMe {
    mapping(address => uint256) public addresToAmount;
    address [] public funders;
    address public owner;

    constructor() public {
        owner = msg.sender; 
    }

    // funkcja payable umożliwa wpłaty msg.sender (typu address) i msg.value (typu uint256) to kto wpłaca i ile eth
    function fund() public payable{
        uint minimumUSD = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "wiadomosc revert: nie stac cie na to");
        addresToAmount[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    function getVersion() public view returns (uint256) {
        // ze strony https://docs.chain.link/docs/reference-contracts/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
    // z wei do dolara
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        // tupel
        /*
        Alternatywnie aby nie stwarać nie potrzebnych zmiennych
        (,int price,,,) = priceFeed.latestRoundData();
        */
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        // zamiana 
        return uint256(price * 10000000000);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmount = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmount;
    }

    //jeżeli modyfier jest nieprawdziwy to kod zostanie zatrzymany
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    // wyciag
    function withdraw() payable public{
        // this - ten kontrakt
        // address(this) - addres tego konteaktu
        //require(msg.sender == owner);
        payable(msg.sender).transfer(address(this).balance);
        for (uint256 funderIndex=0; funderIndex< funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addresToAmount[funder] =0;
        }
        //alternatywnie
        funders = new address [](0);
    }
}