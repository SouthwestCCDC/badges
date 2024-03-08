#!/bin/env bash

# Black team
python generate-badge.py -r 2 -c 3 --pip-colors black -n badge-rc5-black -o output/blackteam 'SWCCDC' '2024' '' 'BLACK TEAM'
python generate-badge.py -r 2 -c 3 --pip-colors gold,black,black,gold,black,black -o output/blackteam -n badge-rc5-black-lead 'SWCCDC' '2024' '' 'BLACK TEAM' 'LEAD'

# # White team
python generate-badge.py -r 2 -c 3 --pip-colors white -n badge-rc5-white -o output/whiteteam 'SWCCDC' '2024' '' 'WHITE TEAM'
python generate-badge.py -r 2 -c 3 --pip-colors gold,white,white,gold,white,white -o output/whiteteam -n badge-rc5-white-lead 'SWCCDC' '2024' '' 'WHITE TEAM' 'LEAD'

# # Gavin
python generate-badge.py -r 2 -c 6 --pip-colors DeepSkyBlue,DeepSkyBlue,DeepSkyBlue,DeepSkyBlue,DeepSkyBlue,DeepSkyBlue,red,red,red,gold,gold,gold -o output/goldteam -n badge-rc5-gold "SWCCDC" "2024" "" "GOLD TEAM" "" "COMPETITION" "DIRECTOR"

# Sponsor/observer
python generate-badge.py -r 2 -c 3 --pip-colors green -o output/visitor -n badge-rc5-visitor "SWCCDC" "2024" "" "OBSERVER"

# Characters
python generate-badge.py -r 2 -c 5 --pip-colors red,red,red,red,red,DeepSkyBlue,DeepSkyBlue,DeepSkyBlue,DeepSkyBlue,DeepSkyBlue -o output/other -n badge-rc5-empire "SWCCDC" "2024" "" "VADM"
python generate-badge.py -r 2 -c 3 --pip-colors red,red,red,DeepSkyBlue,DeepSkyBlue,DeepSkyBlue -o output/other -n badge-rc5-empire "SWCCDC" "2024" "" "CAPT"
python generate-badge.py -r 2 -c 2 --pip-colors red,red,DeepSkyBlue,DeepSkyBlue -o output/other -n badge-rc5-empire "SWCCDC" "2024" "" "LT"
python generate-badge.py -r 2 -c 1 --pip-colors red,DeepSkyBlue -o output/other -n badge-rc5-empire "SW" "CCDC" "2024" "MID"

i=0
# # Blue teams
# for i in {0..8}; do
      python generate-badge.py -r 2 -c 3 --pip-colors blue,DeepSkyBlue,DeepSkyBlue,blue,DeepSkyBlue,DeepSkyBlue -o output/blue$i -n badge-rc5-team$i-coach "SWCCDC" "2024" "" "" "TEAM $i" "COACH"
      python generate-badge.py -r 2 -c 2 --pip-colors blue,DeepSkyBlue,blue,DeepSkyBlue -o output/blue$i -n badge-rc5-team$i-captain "SWCCDC" "2024" "" "" "TEAM $i" "CAPTAIN"
      python generate-badge.py -r 1 -c 2 --pip-colors DeepSkyBlue -o output/blue$i -n badge-rc5-team$i "SWCCDC" "2024" "" "TEAM $i"
# done;
