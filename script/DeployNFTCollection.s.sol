// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {AMNFTCollection} from "../src/AMNFTCollection.sol";

contract DeployNFTCollection is Script {

    function run() external returns(AMNFTCollection){
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); 
        vm.startBroadcast(deployerPrivateKey); 

        string memory name_ = "NAME";
        string memory symbol_ = "SYMBOL"; 
        uint256 totalSupply_ = 2;
        string memory baseUri_ = "ipfs://bafybeifg44s6z72n6k47f6f34k5kmsqbbswnyib4hiqmyecbterylp2yya/";
        AMNFTCollection nftCollection = new AMNFTCollection(name_, symbol_, totalSupply_, baseUri_);

        vm.stopBroadcast();
        return nftCollection;
    }

}