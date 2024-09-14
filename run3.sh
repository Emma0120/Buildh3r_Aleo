#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkpJ7T1xCfwdrdEz6JHJFGa7S6NV63DMkFvDEM92n1hi7Vj
ADDRESS=aleo124y3schxh0740m5phxu4j7xsefv72ucnufx36vltc8lqma8gvcrqpfz550
ENDPOINT=https://api.explorer.aleo.org/v1
" > .env && source .env

leo run finish "{
  owner: aleo124y3schxh0740m5phxu4j7xsefv72ucnufx36vltc8lqma8gvcrqpfz550.private,
  bidder: aleo1tye8udx8hcmt7fwnjwe2cjqywxtfv56ftn6e5e2v6n42833mxvqsq24p96.private,
  amount: 74u64.private,
  is_winner: false.private,
  _nonce: 3311415611996398874992028486979183504969562255228010971421927860741198372967group.public
}"