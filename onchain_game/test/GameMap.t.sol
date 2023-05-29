// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "forge-std/Test.sol";
import "../src/GameMap.sol";
import "test/help/MapParameters.sol";

contract GameMapTest is Test, MapParameters {
    
    GameMap public asia;
    GameMap public estonia;
    GameMap public map;
    GameMap public rome;

    function setUp() public {
        asia = new GameMap(
            asiaTotalContinents,
            asiaTotalCountries,
            asiaTotalWildcards,
            asiaBorders,
            asiaCards,
            asiaContinents
        );

        estonia = new GameMap(
            estoniaTotalContinents,
            estoniaTotalCountries,
            estoniaTotalWildcards,
            estoniaBorders,
            estoniaCards,
            estoniaContinents
        );

        rome = new GameMap(
            romeTotalContinents,
            romeTotalCountries,
            romeTotalWildcards,
            romeBorders,
            romeCards,
            romeContinents
        );
    }

    // TEST CONSTRUCTOR ***************************************************************************

    function testGas() public {
        asia = new GameMap(
            asiaTotalContinents,
            asiaTotalCountries,
            asiaTotalWildcards,
            asiaBorders,
            asiaCards,
            asiaContinents
        );

        asia.validateMapInputs(
            asiaTotalContinents,
            asiaTotalCountries,
            asiaBorders,
            asiaCards,
            asiaContinents
        );
    }
    
    function testConstructorTooManyContinents() public {
        uint8 totalContinents = 17;
        
        vm.expectRevert("Too many continents");
        map = new GameMap(
            totalContinents, 
            romeTotalCountries,
            romeTotalWildcards,
            romeBorders,
            romeCards,
            romeContinents
        );
    }

    function testConstructorTooManyCountries() public {                                             
        uint8 totalCountries = 193;
        
        vm.expectRevert("Too many countries");
        map = new GameMap(
            romeTotalContinents,
            totalCountries, 
            romeTotalWildcards,
            romeBorders,
            romeCards,
            romeContinents
        );
    }

    function testConstructorWrongBorderArrayLength() public {   

        vm.expectRevert("Incorrect border amount");
        map = new GameMap(
            romeTotalContinents,
            romeTotalCountries, 
            romeTotalWildcards,
            romePlusBorders,
            romeCards,
            romeContinents
        );
    }

    function testConstructorOneTooManyBorders() public {   

        vm.expectRevert("Incorrect border amount");
        map = new GameMap(
            romeMinusTotalContinents,
            romeMinusTotalCountries, 
            romeMinusTotalWildcards,
            romeBorders,
            romeMinusCards,
            romeMinusContinents
        );
    }

    function testConstructorOneTooFewBorders() public {   

        vm.expectRevert("Incorrect border amount");
        map = new GameMap(
            romeTotalContinents,
            romeTotalCountries, 
            romeTotalWildcards,
            romeMinusBorders,
            romeCards,
            romeContinents
        );
    }

    function testConstructorTwoTooManyBorders() public {   

        vm.expectRevert("Incorrect border amount");
        map = new GameMap(
            romeMinusTotalContinents,
            romeMinusTotalCountries, 
            romeMinusTotalWildcards,
            romePlusBorders,
            romeMinusCards,
            romeMinusContinents
        );
    }

    function testConstructorTwoTooFewBorders() public {   

        vm.expectRevert("Incorrect border amount");
        map = new GameMap(
            romePlusTotalContinents,
            romePlusTotalCountries, 
            romePlusTotalWildcards,
            romeMinusBorders,
            romePlusCards,
            romePlusContinents
        );
    }

    function testConstructorWrongCardArrayLength() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            romeTotalContinents,
            romeTotalCountries, 
            romeTotalWildcards,
            romeBorders,
            asiaCards,
            romeContinents
        );
    }

    function testConstructorOneTooManyCardsOddTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            romeMinusTotalContinents,
            romeMinusTotalCountries, 
            romeMinusTotalWildcards,
            romeMinusBorders,
            romeCards,
            romeMinusContinents
        );
    }

    function testConstructorOneTooManyCardsEvenTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            estoniaMinusTotalContinents,
            estoniaMinusTotalCountries, 
            estoniaMinusTotalWildcards,
            estoniaMinusBorders,
            estoniaCards,
            estoniaMinusContinents
        );
    }

    function testConstructorOneTooManyCardsFactorOf64() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            asiaMinusTotalContinents,
            asiaMinusTotalCountries, 
            asiaMinusTotalWildcards,
            asiaMinusBorders,
            asiaCards,
            asiaMinusContinents
        );
    }

    function testConstructorOneTooFewCardsOddTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            estoniaTotalContinents,
            estoniaTotalCountries, 
            estoniaTotalWildcards,
            estoniaBorders,
            estoniaMinusCards,
            estoniaContinents
        );
    }

    function testConstructorOneTooFewCardsEvenTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            romeTotalContinents,
            romeTotalCountries, 
            romeTotalWildcards,
            romeBorders,
            romeMinusCards,
            romeContinents
        );
    }

    function testConstructorOneTooFewCardsFactorOf64() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            asiaTotalContinents,
            asiaTotalCountries, 
            asiaTotalWildcards,
            asiaBorders,
            asiaMinusCards,
            asiaContinents
        );
    }

    function testConstructorTwoTooManyCardsOddTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            romeMinusTotalContinents,
            romeMinusTotalCountries, 
            romeMinusTotalWildcards,
            romeMinusBorders,
            romePlusCards,
            romeMinusContinents
        );
    }

    function testConstructorTwoTooManyCardsEvenTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            estoniaMinusTotalContinents,
            estoniaMinusTotalCountries, 
            estoniaMinusTotalWildcards,
            estoniaMinusBorders,
            estoniaPlusCards,
            estoniaMinusContinents
        );
    }

    function testConstructorTwoTooFewCardsOddTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            romePlusTotalContinents,
            romePlusTotalCountries, 
            romePlusTotalWildcards,
            romePlusBorders,
            romeMinusCards,
            romePlusContinents
        );
    }

    function testConstructorTwoTooFewCardsEvenTotal() public {   

        vm.expectRevert("Incorrect card amount");
        map = new GameMap(
            estoniaPlusTotalContinents,
            estoniaPlusTotalCountries, 
            estoniaPlusTotalWildcards,
            estoniaPlusBorders,
            estoniaMinusCards,
            estoniaPlusContinents
        );
    }

    function testConstructorWrongContinentArrayLength() public {
        uint8 totalContinents = 3;

        vm.expectRevert("Incorrect continent amount");
        map = new GameMap(
            totalContinents,
            romeTotalCountries, 
            romeTotalWildcards,
            romeBorders,
            romeCards,
            romeContinents
        );
    }

    function testConstructorEmptyContinent() public {

        vm.expectRevert("Continent must have at least 2 countries");
        map = new GameMap(
            romeTotalContinents,
            romeTotalCountries, 
            romeTotalWildcards,
            romeBorders,
            romeCards,
            romeEmptyContinents
        );
    }

    function testConstructorTotalContinents() public view {

        assert(rome.totalContinents() == romeTotalContinents);
    }

    function testConstructorTotalCountries() public view {

        assert(rome.totalCountries() == romeTotalCountries);
    }

    function testConstructorTotalWildcards() public view {

        assert(rome.totalWildcards() == romeTotalWildcards);
    }

    // TEST MODIFIERS *****************************************************************************

    function testValidContinentZeroContinent() public {
        vm.expectRevert("Invalid continent code");
        rome.getContinentReward(0);
    }

    function testValidContinentOutOfBounds() public {
        vm.expectRevert("Invalid continent code");
        rome.getContinentReward(7);
    }

    function testValidCountryZeroCountry() public {
        vm.expectRevert("Invalid country code");
        rome.getCardType(0);
    }

    function testValidCountryOutOfBounds() public {
        vm.expectRevert("Invalid country code");
        rome.getCardType(45);
    }

    // TEST GETTERS *******************************************************************************

    /*function testGetCardTypeBadCardSet() public {
        map = new GameMap(
            romeTotalContinents,
            romeTotalCountries, 
            romeTotalWildcards,
            romeBorders,
            romeBadCards,
            romeContinents
        );
    }*/

    

    // eventually test validity of bytes arrays... cant check in constructor for efficency reasons
}
