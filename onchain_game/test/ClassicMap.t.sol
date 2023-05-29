// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "forge-std/Test.sol";
import "../src/GameMap.sol";
import "../src/ClassicMap.sol";

contract GameMapTest is Test {
    GameMap public map;

    enum ContinentCodes {
        NO_CONTINENT,
        NORTH_AMERICA,
        SOUTH_AMERICA,
        EUROPE,
        AFRICA,
        ASIA,
        OCEANIA
    }
    
    enum CountryCodes {
        NO_COUNTRY,           // 0
        ALASKA,               // 1
        NORTH_WEST_TERRITORY, // 2
        ALBERTA,              // 3
        WESTERN_UINTED_STATES,// 4
        CENTRAL_AMERICA,      // 5
        GREENLAND,
        ONTARIO,
        QUEBEC,
        EASTERN_UNITED_STATES,
        VENEZUELA,            // 10
        PERU,
        BRAZIL,
        ARGENTINA,
        ICELAND,
        SCANDINAVIA,
        UKRAINE,
        GREAT_BRITAIN,
        NORTHERN_EUROPE,
        WESTERN_EUROPE,
        SOUTHERN_EUROPE,      // 20
        NORTH_AFRICA,
        EGYPT,
        CONGO,
        EAST_AFRICA,
        SOUTH_AFRICA,
        MADAGASCAR,
        SIBERIA,
        URAL,
        CHINA,
        AFGHANISTAN,         // 30
        MIDDLE_EAST,
        INDIA,
        SIAM,
        YAKUTSK,
        IRKUTSK,
        MONGOLIA,
        JAPAN,
        KAMCHATKA,
        INDONESIA,
        NEW_GUINEA,          // 40
        WESTERN_AUSTRALIA,
        EASTERN_AUSTRALIA    // 42
    }

    function setUp() public {
        map = new ClassicMap();
    }

    // TOTALS

    function testTotalContinents() public {
        assertEq(uint256(map.totalContinents()), 6);
    }

    function testTotalCountries() public {
        assertEq(uint256(map.totalCountries()), 42);
    }

    function testTotalWildcards() public {
        assertEq(uint256(map.totalWildcards()), 2);
    }

    // CARD TYPE

    function testAlaskaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.ALASKA))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testNorthWestTerritoryCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.NORTH_WEST_TERRITORY))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testAlbertaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.ALBERTA))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testWesternUnitedStateCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.WESTERN_UINTED_STATES))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testCentralAmericaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.CENTRAL_AMERICA))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testGreenlandCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.GREENLAND))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testOntarioCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.ONTARIO))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testQuebecCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.QUEBEC))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testEasternUnitedStatesCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.EASTERN_UNITED_STATES))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testVenezuelaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.VENEZUELA))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testPeruCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.PERU))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testBrazilCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.BRAZIL))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testArgentinaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.ARGENTINA))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testIcelandCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.ICELAND))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testScandinaviaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.SCANDINAVIA))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testUkraineCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.UKRAINE))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testGreatBritainCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.GREAT_BRITAIN))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testNorthernEuropeCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.NORTHERN_EUROPE))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testWesternEuropeCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.WESTERN_EUROPE))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testSouthernEuropeCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.SOUTHERN_EUROPE))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testNorthAfricaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.NORTH_AFRICA))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testEgyptCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.EGYPT))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testCongoCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.CONGO))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testEastAfricaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.EAST_AFRICA))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testSouthAfricaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.SOUTH_AFRICA))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testMadagascarCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.MADAGASCAR))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testSiberiaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.SIBERIA))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testUralCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.URAL))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testChinaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.CHINA))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testAfghanistanCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.AFGHANISTAN))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testMiddleEastCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.MIDDLE_EAST))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testIndiaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.INDIA))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testSiamCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.SIAM))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testYakutskCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.YAKUTSK))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testIrkutskCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.IRKUTSK))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testMongoliaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.MONGOLIA))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testJapanCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.JAPAN))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    function testKamchatkaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.KAMCHATKA))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testIndonesiaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.INDONESIA))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testNewGuineaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.NEW_GUINEA))), 
            uint256(GameMap.CardType.CAVALRY));
    }

    function testWesternAustraliaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.WESTERN_AUSTRALIA))), 
            uint256(GameMap.CardType.CANNON));
    }

    function testEasternAustraliaCardType() public {
        assertEq(uint256(map.getCardType(uint256(CountryCodes.EASTERN_AUSTRALIA))), 
            uint256(GameMap.CardType.INFANTRY));
    }

    // CONTINENT REWARD

    function testNorthAmericaContinentReward() public {
        assertEq(map.getContinentReward(uint256(ContinentCodes.NORTH_AMERICA)), 5);
    }

    function testSouthAmericaContinentReward() public {
        assertEq(map.getContinentReward(uint256(ContinentCodes.SOUTH_AMERICA)), 2);
    }

    function testEuropeContinentReward() public {
        assertEq(map.getContinentReward(uint256(ContinentCodes.EUROPE)), 5);
    }

    function testAfricaContinentReward() public {
        assertEq(map.getContinentReward(uint256(ContinentCodes.AFRICA)), 3);
    }

    function testAsiaContinentReward() public {
        assertEq(map.getContinentReward(uint256(ContinentCodes.ASIA)), 7);
    }

    function testOceaniaContinentReward() public {
        assertEq(map.getContinentReward(uint256(ContinentCodes.OCEANIA)), 2);
    }

    // CONTINENT SIZE

    function testNorthAmericaContinentSize() public {
        assertEq(map.getContinentSize(uint256(ContinentCodes.NORTH_AMERICA)), 9);
    }

    function testSouthAmericaContinentSize() public {
        assertEq(map.getContinentSize(uint256(ContinentCodes.SOUTH_AMERICA)), 4);
    }

    function testEuropeContinentSize() public {
        assertEq(map.getContinentSize(uint256(ContinentCodes.EUROPE)), 7);
    }

    function testAfricaContinentSize() public {
        assertEq(map.getContinentSize(uint256(ContinentCodes.AFRICA)), 6);
    }

    function testAsiaContinentSize() public {
        assertEq(map.getContinentSize(uint256(ContinentCodes.ASIA)), 12);
    }

    function testOceaniaContinentSize() public {
        assertEq(map.getContinentSize(uint256(ContinentCodes.OCEANIA)), 4);
    }

    // COUNTRIES IN CONTINENT

    function testNorthAmericaCountriesInContinent() public {
        uint256[] memory countries = map.countriesInContinent(
            uint256(ContinentCodes.NORTH_AMERICA));
        
        for (uint256 i; i < countries.length; i++) {
            assertEq(countries[i], i + 1);
        }
    }

    function testSouthAmericaCountriesInContinent() public {
        uint256[] memory countries = map.countriesInContinent(
            uint256(ContinentCodes.SOUTH_AMERICA));

        for (uint256 i; i < countries.length; i++) {
            assertEq(countries[i], i + 10);
        }
    }

    function testEuropeCountriesInContinent() public {
        uint256[] memory countries = map.countriesInContinent(uint256(ContinentCodes.EUROPE));

        for (uint256 i; i < countries.length; i++) {
            assertEq(countries[i], i + 14);
        }
    }

    function testAfricaCountriesInContinent() public {
        uint256[] memory countries = map.countriesInContinent(uint256(ContinentCodes.AFRICA));

        for (uint256 i; i < countries.length; i++) {
            assertEq(countries[i], i + 21);
        }
    }

    function testAsiaCountriesInContinent() public {
        uint256[] memory countries = map.countriesInContinent(uint256(ContinentCodes.ASIA));

        for (uint256 i; i < countries.length; i++) {
            assertEq(countries[i], i + 27);
        }
    }

    function testOceaniaCountriesInContinent() public {
        uint256[] memory countries = map.countriesInContinent(uint256(ContinentCodes.OCEANIA));

        for (uint256 i; i < countries.length; i++) {
            assertEq(countries[i], i + 39);
        }
    }

    // BORDERS

    function testAlaskaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.ALASKA));

        assertEq(borders[0], 2);
        assertEq(borders[1], 3);
        assertEq(borders[2], 38);
    }

    function testNorthWestTerritoryBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.NORTH_WEST_TERRITORY));

        assertEq(borders[0], 1);
        assertEq(borders[1], 3);
        assertEq(borders[2], 7);
        assertEq(borders[3], 6);
    }

    function testAlbertaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.ALBERTA));

        assertEq(borders[0], 1);
        assertEq(borders[1], 2);
        assertEq(borders[2], 7);
        assertEq(borders[3], 4);
    }

    function testWesternUnitedStateBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.WESTERN_UINTED_STATES));

        assertEq(borders[0], 3);
        assertEq(borders[1], 7);
        assertEq(borders[2], 5);
        assertEq(borders[3], 9);
    }

    function testCentralAmericaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.CENTRAL_AMERICA));

        assertEq(borders[0], 4);
        assertEq(borders[1], 9);
        assertEq(borders[2], 10);
    }

    function testGreenlandBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.GREENLAND));

        assertEq(borders[0], 2);
        assertEq(borders[1], 7);
        assertEq(borders[2], 8);
        assertEq(borders[3], 14);
    }

    function testOntarioBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.ONTARIO));

        assertEq(borders[0], 2);
        assertEq(borders[1], 3);
        assertEq(borders[2], 4);
        assertEq(borders[3], 6);
        assertEq(borders[4], 8);
        assertEq(borders[5], 9);
    }

    function testQuebecBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.QUEBEC));
        
        assertEq(borders[0], 6);
        assertEq(borders[1], 7);
        assertEq(borders[2], 9);
    }

    function testEasternUnitedStatesBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.EASTERN_UNITED_STATES));

        assertEq(borders[0], 4);
        assertEq(borders[1], 5);
        assertEq(borders[2], 7);
        assertEq(borders[3], 8);
    }

    function testVenezuelaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.VENEZUELA));

        assertEq(borders[0], 5);
        assertEq(borders[1], 11);
        assertEq(borders[2], 12);
    }

    function testPeruBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.PERU));

        assertEq(borders[0], 10);
        assertEq(borders[1], 12);
        assertEq(borders[2], 13);
    }

    function testBrazilBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.BRAZIL));

        assertEq(borders[0], 10);
        assertEq(borders[1], 11);
        assertEq(borders[2], 13);
        assertEq(borders[3], 21);
    }

    function testArgentinaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.ARGENTINA));

        assertEq(borders[0], 11);
        assertEq(borders[1], 12);
    }

    function testIcelandBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.ICELAND));

        assertEq(borders[0], 6);
        assertEq(borders[1], 17);
    }

    function testScandinaviaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.SCANDINAVIA));

        assertEq(borders[0], 16);
        assertEq(borders[1], 18);
    }

    function testUkraineBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.UKRAINE));

        assertEq(borders[0], 15);
        assertEq(borders[1], 28);
        assertEq(borders[2], 30);
        assertEq(borders[3], 31);
        assertEq(borders[4], 18);
        assertEq(borders[5], 20);
    }

    function testGreatBritainBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.GREAT_BRITAIN));

        assertEq(borders[0], 14);
        assertEq(borders[1], 18);
        assertEq(borders[2], 19);
    }

    function testNorthernEuropeBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.NORTHERN_EUROPE));

        assertEq(borders[0], 15);
        assertEq(borders[1], 16);
        assertEq(borders[2], 17);
        assertEq(borders[3], 19);
        assertEq(borders[4], 20);
    }

    function testWesternEuropeBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.WESTERN_EUROPE));

        assertEq(borders[0], 17);
        assertEq(borders[1], 18);
        assertEq(borders[2], 20);
        assertEq(borders[3], 21);
    }

    function testSouthernEuropeBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.SOUTHERN_EUROPE));

        assertEq(borders[0], 16);
        assertEq(borders[1], 18);
        assertEq(borders[2], 19);
        assertEq(borders[3], 21);
        assertEq(borders[4], 22);
        assertEq(borders[5], 31);
    }

    function testNorthAfricaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.NORTH_AFRICA));

        assertEq(borders[0], 12);
        assertEq(borders[1], 19);
        assertEq(borders[2], 20);
        assertEq(borders[3], 22);
        assertEq(borders[4], 23);
        assertEq(borders[5], 24);
    }

    function testEgyptBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.EGYPT));

        assertEq(borders[0], 20);
        assertEq(borders[1], 21);
        assertEq(borders[2], 24);
        assertEq(borders[3], 31);
    }

    function testCongoBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.CONGO));

        assertEq(borders[0], 21);
        assertEq(borders[1], 24);
        assertEq(borders[2], 25);
    }

    function testEastAfricaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.EAST_AFRICA));

        assertEq(borders[0], 21);
        assertEq(borders[1], 22);
        assertEq(borders[2], 23);
        assertEq(borders[3], 25);
        assertEq(borders[4], 26);
        assertEq(borders[5], 31);
    }

    function testSouthAfricaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.SOUTH_AFRICA));

        assertEq(borders[0], 23);
        assertEq(borders[1], 24);
        assertEq(borders[2], 26);
    }

    function testMadagascarBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.MADAGASCAR));

        assertEq(borders[0], 24);
        assertEq(borders[1], 25);
    }

    function testSiberiaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.SIBERIA));

        assertEq(borders[0], 28);
        assertEq(borders[1], 29);
        assertEq(borders[2], 34);
        assertEq(borders[3], 35);
        assertEq(borders[4], 36);
    }

    function testUralBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.URAL));

        assertEq(borders[0], 16);
        assertEq(borders[1], 27);
        assertEq(borders[2], 29);
        assertEq(borders[3], 30);
    }

    function testChinaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.CHINA));

        assertEq(borders[0], 27);
        assertEq(borders[1], 28);
        assertEq(borders[2], 30);
        assertEq(borders[3], 32);
        assertEq(borders[4], 33);
        assertEq(borders[5], 36);
    }

    function testAfghanistanBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.AFGHANISTAN));

        assertEq(borders[0], 16);
        assertEq(borders[1], 28);
        assertEq(borders[2], 29);
        assertEq(borders[3], 31);
        assertEq(borders[4], 32);
    }

    function testMiddleEastBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.MIDDLE_EAST));

        assertEq(borders[0], 16);
        assertEq(borders[1], 22);
        assertEq(borders[2], 30);
        assertEq(borders[3], 32);
        assertEq(borders[4], 20);
        assertEq(borders[5], 24);
    }

    function testIndiaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.INDIA));

        assertEq(borders[0], 29);
        assertEq(borders[1], 30);
        assertEq(borders[2], 31);
        assertEq(borders[3], 33);
    }

    function testSiamBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.SIAM));

        assertEq(borders[0], 29);
        assertEq(borders[1], 32);
        assertEq(borders[2], 39);
    }

    function testYakutskBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.YAKUTSK));

        assertEq(borders[0], 27);
        assertEq(borders[1], 35);
        assertEq(borders[2], 38);
    }

    function testIrkutskBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.IRKUTSK));

        assertEq(borders[0], 27);
        assertEq(borders[1], 34);
        assertEq(borders[2], 36);
        assertEq(borders[3], 38);
    }

    function testMongoliaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.MONGOLIA));

        assertEq(borders[0], 29);
        assertEq(borders[1], 35);
        assertEq(borders[2], 37);
        assertEq(borders[3], 38);
        assertEq(borders[4], 27);
    }

    function testJapanBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.JAPAN));

        assertEq(borders[0], 36);
        assertEq(borders[1], 38);
    }

    function testKamchatkaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.KAMCHATKA));

        assertEq(borders[0], 1);
        assertEq(borders[1], 34);
        assertEq(borders[2], 35);
        assertEq(borders[3], 36);
        assertEq(borders[4], 37);
    }

    function testIndonesiaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.INDONESIA));

        assertEq(borders[0], 33);
        assertEq(borders[1], 41);
        assertEq(borders[2], 40);
    }

    function testNewGuineaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.NEW_GUINEA));

        assertEq(borders[0], 39);
        assertEq(borders[1], 41);
        assertEq(borders[2], 42);
    }

    function testWesternAustraliaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.WESTERN_AUSTRALIA));

        assertEq(borders[0], 39);
        assertEq(borders[1], 40);
        assertEq(borders[2], 42);
    }

    function testEasternAustraliaBorders() public {
        uint256[] memory borders = map.getBorders(uint256(CountryCodes.EASTERN_AUSTRALIA));

        assertEq(borders[0], 40);
        assertEq(borders[1], 41);
    }
}
