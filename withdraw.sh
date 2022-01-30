#!/bin/bash

lastcol='| sed -r "s/.* //g"'
providerid="$(myst cli identities list | awk '{print $NF}')"
providerid=$(echo "$providerid" | cut -c5-100)
balance=$(myst cli identities get "$providerid" | grep Balance: | sed -r "s/.* //g")
walletaddr=$(myst cli identities get-payout-address "$providerid" | sed -r "s/.* //g")
#walletaddr=$(echo "$walletaddr" | cut -c5-100)

echo $balance
echo $providerid
echo $walletaddr

timewithdraw=$(echo "$balance >= 0.5" | bc)
if [ $timewithdraw -ge 0 ]; then 
  echo "withdraw time!"
  echo $(myst cli identities withdraw "$providerid" "$walletaddr" 137)
fi
# 1 - Ethereum network
# 137 - Matic/Polygon
