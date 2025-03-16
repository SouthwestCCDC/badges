#!/bin/env bash

# Red team
python generate-badge.py --name=badge --role=redteam --color-top=black --color-bottom=white --color-inset=red --color-button=black --color-text=red --color-badge=red --ball-text=R --omit-clip 'SWCCDC' '2025' ' ' 'RED' 'TEAM'

# Black team
python generate-badge.py --name=badge --role=blackteam --color-top=black --color-bottom=white --color-inset=black --color-button=white --color-text=white --color-badge=black --ball-text=B 'SWCCDC' '2025' ' ' 'BLACK' 'TEAM'
# Black team lead
# python generate-badge.py --name=badge --role=blackteamlead --color-top=black --color-bottom=white --color-inset=black --color-button=white --color-text=white --color-badge=black --ball-text=B 'SWCCDC' '2025' ' ' 'BLACK TEAM' 'LEAD'

# White team
python generate-badge.py --name=badge --role=whiteteam --color-top=white --color-bottom=white --color-inset=black --color-button=black --color-text=black --color-badge=white --ball-text=W 'SWCCDC' '2025' ' ' 'WHITE' 'TEAM'
# python generate-badge.py --name=badge --role=whiteteam --color-top=white --color-bottom=white --color-inset=black --color-button=black --color-text=black --color-badge=white --ball-text=W --omit-clip 'SWCCDC' '2025' ' ' 'WHITE TEAM' 'LEAD'

# Orange team
python generate-badge.py --name=badge --role=orangeteam --color-top=red --color-bottom=white --color-inset=black --color-button=white --color-text=black --color-badge=orange --ball-text='' 'SWCCDC' '2025' ' ' 'ORANGE' 'TEAM'
# python generate-badge.py --name=badge --role=orangeteam-lead --color-top=red --color-bottom=white --color-inset=black --color-button=white --color-text=black --color-badge=orange --ball-text='' 'SWCCDC' '2025' ' ' 'ORANGE' 'TEAM LEAD'

# Gold team
python generate-badge.py --name=badge --role=goldteam --color-top=red --color-bottom=white --color-inset=black --color-button=white --color-text=yellow --color-badge=yellow --ball-text=G --omit-clip 'SWCCDC' '2025' ' ' 'GOLD' 'TEAM'

# Observer
python generate-badge.py --name=badge --role=guest --color-top=green --color-bottom=white --color-inset=black --color-button=green --color-text=white --color-badge=green --ball-text=GUEST --ball-text-size=6 --omit-clip 'SWCCDC' '2025' ' ' 'GUEST'

# Blue teams
for i in {0..8}; do
      python generate-badge.py --name=badge --role="team$i" --color-top=red --color-bottom=white --color-inset=black --color-button=blue --color-text=blue --color-badge=blue --ball-text="" 'SWCCDC' '2025' ' ' "TEAM $i"
      python generate-badge.py --name=badge --role="coach$i" --color-top=blue --color-bottom=white --color-inset=black --color-button=blue --color-text=white --color-badge=white --ball-text=C --omit-clip 'SWCCDC' '2025' ' ' "TEAM $i" ' COACH'
done
