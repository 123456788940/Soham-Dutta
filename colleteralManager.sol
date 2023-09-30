// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract colleteralManager is AccessControl {
    // Role to manage asset parameters
    bytes32 public Manager_Role=keccak256("Manager_Role");
    
    // struct to represent an asset's parameter's
    struct _AssetParameters {
        uint liquidationThreshold;
        uint liquidationBonus;

    }

    // mapping to store assAet parameters by asset address
    mapping(address=>_AssetParameters) public assetParameters;
   

    // event to log asset parameters update
    event AssetParametersUpdated(address indexed asset, uint liquidationThreshold, uint liquidationBonus);


    constructor() {
        //Assign the deployer the default admin role
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }


    //Modifiers to restrict access to only managers
    modifier onlyManager(){
        require(hasRole(Manager_Role, msg.sender), "not a manager");
        _;
    }

    // function to set update asset parameters (accissible only by managers)
    function setAssetParameters(address asset, uint thresHold, uint bonus) external onlyManager {
        // Update the asset parameters
        assetParameters[asset]= _AssetParameters(thresHold, bonus);
        // emit an event to log the update
        emit AssetParametersUpdated(asset, thresHold, bonus);

    }

    // function to get asset parameters
    function getAssetParameters(address asset, uint userDebt, uint userCollateral) external view returns(uint _liquidationPrice){
        // Retrieve asset parameters
        _AssetParameters storage params = assetParameters[asset];
        require(params.liquidationThreshold>0, "Asset parameters not set");
         _liquidationPrice = (userDebt * params.liquidationBonus) / userCollateral;
         return _liquidationPrice;

       
        

    }

}
