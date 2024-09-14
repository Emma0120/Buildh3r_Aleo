#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

echo "
We will be playing the role of three parties.

The private key and address of the first bidder.
private_key: APrivateKey1zkp45BFdFxBmhi6VzBbGjRdofFasYBfFZk1CPqKfv5yxBpZ
address: aleo1faxexxp9ftc6prmss8sadtjpwwst70dxv94wm5uel94ut06hecpsgyuz2x

The private key and address of the second bidder.
private_key: APrivateKey1zkpA4sXUaLjYa3qHwBAHeWezapVHvVFfKtLmKtZTW9wYDuV
address: aleo1tye8udx8hcmt7fwnjwe2cjqywxtfv56ftn6e5e2v6n42833mxvqsq24p96

The private key and address of the auctioneer.
private_key: APrivateKey1zkpAqZVZ8WnwjBb4Lw8s1NJ6Ui4kQzWUADUtTSvHfcdS3Yr
address: aleo1g3dz2fyk70wswd2ce3zf0t6dlx27s947sm0xqqz07cxlq2ghrvgqu03qwv
"

echo "
Let's start an auction!

###############################################################################
########                                                               ########
########           Step 0: Initialize a new 2-party auction            ########
########                                                               ########
########                -------------------------------                ########
########                |  OPEN   |    A    |    B    |                ########
########                -------------------------------                ########
########                |   Bid   |         |         |                ########
########                -------------------------------                ########
########                                                               ########
###############################################################################
"

# echo "
# Let's take the role of the first bidder - we'll swap in the private key and address of the first bidder to .env.

# We're going to run the transition function "place_bid", slotting in the first bidder's public address and the amount that is being bid. The inputs are the user's public address and the amount being bid.

echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkp45BFdFxBmhi6VzBbGjRdofFasYBfFZk1CPqKfv5yxBpZ
ADDRESS=aleo1faxexxp9ftc6prmss8sadtjpwwst70dxv94wm5uel94ut06hecpsgyuz2x
ENDPOINT=https://api.explorer.aleo.org/v1
" > .env && source .env

leo run place_bid $ADDRESS 40u64


echo "
###############################################################################
########                                                               ########
########         Step 1: The first bidder places a bid of 10           ########
########                                                               ########
########                -------------------------------                ########
########                |  OPEN   |    A    |    B    |                ########
########                -------------------------------                ########
########                |   Bid   |  40    |         |                ########
########                -------------------------------                ########
########                                                               ########
###############################################################################
"

#

echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkpA4sXUaLjYa3qHwBAHeWezapVHvVFfKtLmKtZTW9wYDuV
ADDRESS=aleo1tye8udx8hcmt7fwnjwe2cjqywxtfv56ftn6e5e2v6n42833mxvqsq24p96
ENDPOINT=https://api.explorer.aleo.org/v1
" > .env && source .env

# Have the second bidder place a bid of 90.
leo run place_bid $ADDRESS 90u64

echo "
###############################################################################
########                                                               ########
########          Step 2: The second bidder places a bid of 90         ########
########                                                               ########
########                -------------------------------                ########
########                |  OPEN   |    A    |    B    |                ########
########                -------------------------------                ########
########                |   Bid   |   40    |   90    |                ########
########                -------------------------------                ########
########                                                               ########
###############################################################################
"

# echo "
# Now, let's take the role of the auctioneer, so we can determine which bid wins. Let's swap our keys to the auctioneer and run the resolve command on the output of the two bids from before. The resolve command takes the two output records from the bids as inputs and compares them to determine which bid wins.


# leo run resolve "{
#    owner: aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.private,
#   bidder: aleo1faxexxp9ftc6prmss8sadtjpwwst70dxv94wm5uel94ut06hecpsgyuz2x.private,
#     amount: 10u64.private,
#     is_winner: false.private,
#     _nonce: 4668394794828730542675887906815309351994017139223602571716627453741502624516group.public
# }" "{
#    owner: aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.private,
#   bidder: aleo1tye8udx8hcmt7fwnjwe2cjqywxtfv56ftn6e5e2v6n42833mxvqsq24p96.private,
#     amount: 90u64.private,
#     is_winner: false.private,
#     _nonce: 5952811863753971450641238938606857357746712138665944763541786901326522216736group.public
# }"


# Swaps in the private key of the auctioneer to .env.
# echo "
# NETWORK=testnet
# PRIVATE_KEY=APrivateKey1zkpAqZVZ8WnwjBb4Lw8s1NJ6Ui4kQzWUADUtTSvHfcdS3Yr
# " > .env

# # Have the auctioneer select the winning bid.
# leo run resolve "{
#         owner: aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.private,
#         bidder: aleo1faxexxp9ftc6prmss8sadtjpwwst70dxv94wm5uel94ut06hecpsgyuz2x.private,
#         amount: 40u64.private,
#         is_winner: false.private,
#         _nonce: 4668394794828730542675887906815309351994017139223602571716627453741502624516group.public
#     }" "{
#         owner: aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.private,
#         bidder: aleo1esqchvevwn7n5p84e735w4dtwt2hdtu4dpguwgwy94tsxm2p7qpqmlrta4.private,
#         amount: 90u64.private,
#         is_winner: false.private,
#         _nonce: 5952811863753971450641238938606857357746712138665944763541786901326522216736group.public
#     }"

# echo "
# ###############################################################################
# ########                                                               ########
# ########     Step 3: The auctioneer determines the winning bidder      ########
# ########                                                               ########
# ########                -------------------------------                ########
# ########                |  OPEN   |    A    |  → B ←  |                ########
# ########                -------------------------------                ########
# ########                |   Bid   |   10    |  → 90 ← |                ########
# ########                -------------------------------                ########
# ########                                                               ########
# ###############################################################################
# "

# echo "
# Keeping the key environment the same since we're still the auctioneer, let's finalize the auction and label the winning output as the winner. The finish transition takes the winning output bid as the input and marks it as such.
# Swap in the private key of the second bidder to .env.
# echo "
# NETWORK=testnet
# PRIVATE_KEY=APrivateKey1zkpA4sXUaLjYa3qHwBAHeWezapVHvVFfKtLmKtZTW9wYDuV
# ENDPOINT=https://api.explorer.aleo.org/v1
# " > .env

# leo run finish "{
#    owner: aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.private,
#   bidder: aleo1tye8udx8hcmt7fwnjwe2cjqywxtfv56ftn6e5e2v6n42833mxvqsq24p96.private,
#   amount: 90u64.private,
#   is_winner: false.private,
#   _nonce: 3179340044458851034345982069704482938035049861938661083177828778882449319356group.public
# }"
# # Have the auctioneer finish the auction.
# leo run finish "{
#         owner: aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.private,
#         bidder: aleo1esqchvevwn7n5p84e735w4dtwt2hdtu4dpguwgwy94tsxm2p7qpqmlrta4.private,
#         amount: 90u64.private,
#         is_winner: false.private,
#         _nonce: 5952811863753971450641238938606857357746712138665944763541786901326522216736group.public
#     }"

# echo "
# ###############################################################################
# ########                                                               ########
# ########              The auctioneer completes the auction.            ########
# ########                                                               ########
# ########                -------------------------------                ########
# ########                |  CLOSE  |    A    |  → B ←  |                ########
# ########                -------------------------------                ########
# ########                |   Bid   |   10    |  → 90 ← |                ########
# ########                -------------------------------                ########
# ########                                                               ########
# ###############################################################################
# "
