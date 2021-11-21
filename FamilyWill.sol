pragma solidity ^0.5.0; 

contract FamilyWill { 
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public {
        owner = msg.sender;
        fortune = msg.value; 
    }

    // Create Modifier so only owner can call contract
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Only allocate funds if death has occurred

    modifier mustBeDeceased {
        require(deceased == true);
        _;
    }

    // list of family wallets
    address payable[] familyWallets;

    // map through inheritance
    mapping(address => uint) inheritance;

    // set inheritance for each address
    function payout() private mustBeDeceased {
        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}