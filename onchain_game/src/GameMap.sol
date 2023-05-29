// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "forge-std/console.sol";
                                                                               
contract GameMap {

    uint8 public totalCountries;
    uint8 public totalContinents;
    uint8 public totalWildcards;
    // countries borders stored in 8 bytes, each border gets a byte. eg: 
    // country 1 = borders[0][0-7], country 4 = borders[0][24-31], country 5 = borders[1][0-7], 
    // country 32 = borders[9][16-23]
    bytes32[] private borders; 
    // each card type stored in half of a byte, wildcards excluded
    bytes32[] private cardType; 
    // continent data stored as: reward byte - length byte - country - country - country ...
    bytes32[] private continents; 
    // function must be called to populate. lower country code is the only border recorded, 
    // to avoid duplicates. indexed: country => country => border? where lower country is first
    mapping(uint256 => mapping(uint256 => bool)) private borderExists; 
    // check wether borders already populated for this country. indexed country => populated?
    mapping(uint256 => bool) public bordersRecorded;
    
    enum CardType { INFANTRY, CAVALRY, CANNON } 

    modifier validContinent(uint256 continentCode) {
        require(continentCode != 0 && continentCode <= totalContinents, "Invalid continent code");
        _;
    }

    modifier validCountry(uint256 countryCode) {
        require(countryCode != 0 && countryCode <= totalCountries, "Invalid country code");
        _;
    }

    constructor (
        uint8 _totalContinents, 
        uint8 _totalCountries, 
        uint8 _totalWildcards,
        bytes32[] memory _borders,
        bytes32[] memory _cardType,
        bytes32[] memory _continents
    ) {

        //validateMapInputs(_totalContinents, _totalCountries, _borders, _cardType, _continents);
        
        totalContinents = _totalContinents;
        totalCountries = _totalCountries;
        totalWildcards = _totalWildcards;
        borders = _borders;
        cardType = _cardType;
        continents = _continents;
    }

    function validateMapInputs(
        uint8 _totalContinents, 
        uint8 _totalCountries, 
        bytes32[] memory _borders,
        bytes32[] memory _cardType,
        bytes32[] memory _continents
    ) public {
        // rational limits on map size
        require(_totalContinents <= 16, "Too many continents");
        require(_totalCountries <= 192, "Too many countries");
        

        bool bordersDimensions;
        // special case where countries%4=0, check last element in different way or i out of bound
        if (_totalCountries % 4 == 0) {
            // if countries%4=0, check to make sure last index is full
            bordersDimensions = _borders[_borders.length - 1][24] != 0;
        // countries%4 !=0
        } else {
            bordersDimensions = 
                // last country exists. each country 8 bytes, last country = length%4*8 - 1*8 
                _borders[_borders.length - 1][((_totalCountries % 4) - 1) * 8] != 0 && 
                // no border exists after the last country. country after last = length%4
                _borders[_borders.length - 1][(_totalCountries % 4) * 8] == 0;
        }
        // borders has numCountries/4 words, rounded up
        require(_borders.length == (_totalCountries + 3) / 4 && bordersDimensions,
            "Incorrect border amount");

        uint256 borderingCountryCode;
        for (uint256 i; i < _borders.length; i++) {
            for (uint256 j; j < 32; j++) {
                if ((i * 4) + (j / 8) < _totalCountries) {
                    borderingCountryCode = uint8(_borders[i][j]);
                    
                    // when j%8=0, this is the first border of a country, and must exist
                    if (j % 8 == 0) {
                        //console.log(borderingCountryCode);
                        require(
                            borderingCountryCode != 0, 
                            "Every country must have at least one border"
                        );
                    }

                    require(
                        borderingCountryCode <= _totalCountries, 
                        "Cannot border non-existing country"
                    );

                    //recordBorder(i + 1, borderingCountryCode);
                }
            }
        }

        bool[] memory countryChecked = new bool[](_totalCountries + 1);
        for (uint256 i; i < _totalContinents; i++) {
            //console.log("continent");
            // check each continent has at least 2 countries
            require(uint8(_continents[i][0]) >= 2, "Continent must have at least 2 countries"); 

            //console.log(uint8(_continents[i][1]));
            for(uint256 j; j < uint8(_continents[i][1]); j++) {
                //console.log(uint8(_continents[i][j + 2]));
                require(
                    !countryChecked[uint8(_continents[i][j + 2])], 
                    "Country cannot exist in two continents"
                );
                require(
                    uint8(_continents[i][j + 2]) <= _totalCountries, 
                    "Continent cannot contain non-existing country"
                );
                
                countryChecked[uint8(_continents[i][j + 2])] = true;
            }
        }   
        
        bool cardsDimensions;
        uint8 lastByte;
        // special case where countries%64=0, check last element in different way or i out of bound
        if (_totalCountries % 64 == 0) {
            // if countries%4=0, check to make sure last index is full 
            // fail when last byte contains a 0
            lastByte = uint8(_cardType[_cardType.length - 1][31]);
            cardsDimensions = lastByte > 8 && lastByte % 8 != 0; 
        } else {
            // each country 1/2 bytes. if countries is even, last byte full, next byte empty
            
            if (_totalCountries % 2 == 0) {
                lastByte = uint8(_cardType[_cardType.length - 1][((_totalCountries / 2) % 32) - 1]);
                // last country exists. last country = length/2%32 - 1
                cardsDimensions = uint8(lastByte) > 8 && uint8(lastByte) % 8 != 0 &&
                    // no cardType exists after the last country. 
                    _cardType[_cardType.length - 1][(_totalCountries / 2) % 32] == 0;
            // if countries is odd, last byte half full
            } else {
                lastByte = uint8(_cardType[_cardType.length - 1][((_totalCountries / 2) % 32)]);
                // last byte must =0xn0
                cardsDimensions = uint8(lastByte) > 8 && uint8(lastByte) % 8 == 0; 
            }
        }
        
        // cardType has numCountries/64 words, rounded up
        require( _cardType.length == (_totalCountries + 63) / 64 && cardsDimensions, 
            "Incorrect card amount");

        console.log((_totalCountries + 1) / 2);
        for (uint256 i; i < (_totalCountries + 1) / 2; i++) {
            require(countryChecked[i + 1], "Every country must have a continent");
            //console.log(i);
            //console.log(uint8(_cardType[i / 32][i % 32]) >> 4);
            //console.log(uint8(_cardType[i / 32][i % 32]) & 0x0f);
            
            
            if (i == ((_totalCountries + 1) / 2) - 1 && _totalCountries % 2 == 1) {
                require(
                    _cardType[i / 32][i % 32] >> 4 != 0 &&
                    uint8(_cardType[i / 32][i % 32] >> 4) <= 3
                    , "panic");
            } else {
                require(
                    _cardType[i / 32][i % 32] >> 4 != 0 &&
                    _cardType[i / 32][i % 32] & 0x0f != 0 && 
                    uint8(_cardType[i / 32][i % 32] >> 4) <= 3 &&
                    uint8(_cardType[i / 32][i % 32] & 0x0f) <= 3
                    , "panic");
            }
        }

        require(_continents.length == _totalContinents, "Incorrect continent amount");
    }

    function getCardType(uint256 countryCode) 
        public 
        view 
        validCountry(countryCode) 
        returns (CardType) 
    {
        // country 1-64 in cardType[0], 65- 128 in cardType[2]
        uint256 arrayIndex = (countryCode - 1) / 64; 
        // countryNumber 128 is cardType[2][0] because 128 % 64 = 0
        uint256 arrayOffset = (countryCode - 1) % 64; 
        // gets 1 byte, or 2 adjacent card types
        bytes1 typeByte = cardType[arrayIndex][arrayOffset / 2]; 
        // filter the desired card type fixing)
        return CardType(uint8(arrayOffset % 2 == 0 ? typeByte >> 4 : typeByte & 0x0f) - 1);
    }

    function getContinentReward(uint256 continentCode) 
        public 
        view 
        validContinent(continentCode) 
        returns(uint256) 
    {
        return uint8(continents[continentCode - 1][0]);
    }

    function getContinentSize(uint256 continentCode) 
        public 
        view 
        validContinent(continentCode) 
        returns(uint256) 
    {
        return uint8(continents[continentCode - 1][1]);
    }

    function countriesInContinent(uint256 continentCode) 
        public 
        view 
        validContinent(continentCode) 
        returns(uint256[] memory) 
    {
        uint256 size = getContinentSize(continentCode);
        uint256[] memory countries = new uint256[](size);    
    
        for (uint256 i = 0; i < size; i++) {
            countries[i] = uint256(uint8(continents[continentCode - 1][i + 2]));
        }
        return countries;
    }

    function getBorders(uint256 countryCode) 
        public 
        view
        validCountry(countryCode) 
        returns(uint256[] memory) 
    {
        // countries stored 4 to a word, arrayIndex is the word containing this country
        uint256 arrayIndex = (countryCode - 1) / 4;
        // arrayOffset is the location of this country in its word 
        uint256 arrayOffset = ((countryCode - 1) % 4) * 8;
        
        uint256 size = getBordersSize(arrayIndex, arrayOffset);
        uint256[] memory countryBorders = new uint256[](size);
        
        for (uint256 i; i < size; i++) {
            countryBorders[i] = uint256(uint8(borders[arrayIndex][i + arrayOffset]));
        }
        
        return countryBorders;
    }

    function hasBorder(uint256 countryCode, uint256 borderingCode)
        public
        view
        validCountry(countryCode)
        validCountry(borderingCode)
        returns(bool border)
    {
        // only min will be recorded
        require(bordersRecorded[countryCode] || bordersRecorded[borderingCode], 
            "Borders must be recorded before existence can be checked");

        uint256 min;
        uint256 max;

        if (countryCode < borderingCode) {
            min = countryCode;
            max = borderingCode;
        } else {
            min = borderingCode;
            max = countryCode;
        }

        return borderExists[min][max];
    }

    function recordBorders(uint256 countryCode) public validCountry(countryCode) {
        uint256 arrayIndex = (countryCode - 1) / 4;
        uint256 arrayOffset = ((countryCode - 1) % 4) * 8;
        uint256 size = getBordersSize(arrayIndex, arrayOffset);
        
        for (uint256 i; i < size; i++) {
            recordBorder(countryCode, uint256(uint8(borders[arrayIndex][i + arrayOffset])));
        }
        
        bordersRecorded[countryCode] = true;
    }

    function recordBorder(uint256 countryCode, uint256 borderingCode) private {
        uint256 min;
        uint256 max;

        if (countryCode < borderingCode) {
            min = countryCode;
            max = borderingCode;
        } else {
            min = borderingCode;
            max = countryCode;
        }

        borderExists[min][max] = true;
    }

    function getBordersSize(uint256 arrayIndex, uint256 arrayOffset) 
        private 
        view 
        returns(uint256 size) 
    {
        for (size; size < 8; size++) {
            if (borders[arrayIndex][size + arrayOffset] == 0) {
                return size;
            } 
        }
    }
}