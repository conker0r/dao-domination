import json
import sys

def convert_to_json(card_file, map_file, output_file):
    continents = list() 
    borders = list()
    total_continents = 0
    total_countries = 0
    total_wildcards = 0
    state = "skip"
    
    # Read map file and extract data
    with open(map_file, 'r') as file:
        for line in file:
            line = line.strip()  # Remove leading/trailing whitespaces

            if line: # skip empty lines
                line_array = line.split()
                if line == "[continents]":
                    state = "continents"
                    continue

                if line == "[countries]":
                    state = "countries"
                    continue

                if line == "[borders]":
                    state = "borders"
                    continue
                
                if state == "continents":
                    continent = {
                        "name": line_array[0],
                        "reward": int(line_array[1]),
                        "length": 0,
                        "countries": list()
                    }
                    continents.append(continent)
                    total_continents += 1
                
                if state == "countries":
                    continents[int(line_array[2]) - 1]["length"] += 1
                    continents[int(line_array[2]) - 1]["countries"].append(int(line_array[0]))
                    total_countries += 1

                if state == "borders":
                    country_borders = line_array[1:]
                    borders.append(country_borders)

    # read cards
    card_bytes = list()
    card_bytes.append("0x")
    with open(card_file, 'r') as file:
        index = 0
        count = 0
        state = "skip"

        for line in file:
            line = line.strip()  # Remove leading/trailing whitespaces

            if line: # skip empty lines
                if line == "[cards]":
                    state = "cards"
                    continue

                if line == "wildcard":
                    state = "skip"
                    total_wildcards += 1

                if state == "cards":
                    card_type = line.split()[0]
                    
                    if card_type == "Infantry":
                        card_bytes[index] += "1"
                    elif card_type == "Cavalry":
                        card_bytes[index] += "2"
                    elif card_type == "Cannon":
                        card_bytes[index] += "3"

                    count +=1
                    if count % 64 == 0:
                        index += 1
                        card_bytes.append("0x")
        
    # append 0s to card_bytes
    if card_bytes[len(card_bytes) - 1] == "0x":
        card_bytes.remove("0x")
    while len(card_bytes[len(card_bytes) - 1]) < 66:
        card_bytes[len(card_bytes) - 1] += "0"
        
    # format continent data into bytes array
    continents_bytes = list()
    for continent in continents:
        continent_string = "0x" + format(continent["reward"], "02x")
        continent_string += format(continent["length"], "02x")
        
        for i in range(30):
            if i < len(continent["countries"]):
                continent_string += format(continent["countries"][i], "02x")
            else:
                continent_string += "00"

        continents_bytes.append(continent_string)

    # format borders data into bytes array
    borders_bytes = list()
    for i in range(int(len(borders) / 4) + 1):
        four_countries = "0x"

        for j in range(4):
            if (4 * i) + j < len(borders):
                for k in range(8):
                    if k < len(borders[(4 * i) + j]):
                        four_countries += format(int(borders[(4 * i) + j][k]), "02x")
                    else:
                        four_countries += "00"
            

        if len(four_countries) > 2:
            while len(four_countries) < 66:
                four_countries += "0"
            borders_bytes.append(four_countries)
        

    # Convert data to JSON
    json_data = dict()
    json_data["totalContinents"] = total_continents
    json_data["totalCountries"] = total_countries
    json_data["totalWildcards"] = total_wildcards
    json_data["borders"] = borders_bytes
    json_data["cardType"] = card_bytes
    json_data["continents"] = continents_bytes
    
    
    # Write JSON to output file
    with open(output_file, 'w') as file:
        json.dump(json_data, file, indent=4)

def main(file_name):

    card_file = "map/" + file_name + ".cards"
    map_file = "map/" + file_name + ".map"
    output_file = "json/" + file_name + ".json"
    convert_to_json(card_file, map_file, output_file)

main(sys.argv[1])