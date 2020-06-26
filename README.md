# Bitsim Node

> Bitcoin Simulation Node 

<img src='./assets/akira.jpeg' width=500px>

### about

neoregtest is a 'bitcoin node in a box' meant for mocking test scenarios. 

neoregtest is slightly different from regular regtest mode, because it supports: 
- mainnet addresses
- mainnet magic bytes

### instructions

```bash
# pull image
docker pull planaria/bitsim:0.0.2

# start node
docker run -d -p 18332-18333:18332-18333 planaria/bitsim:0.0.2

# hit RPC 
bitcoin-cli -regtest -rpcport=18332 help

# validate address
bitcoin-cli -regtest -rpcport=18332 validateaddress "1DzqBck9oyCBzxJbbje2s15deZis6BeATi"

# mine blocks
bitcoin-cli -regtest -rpcport=18332 generatetoaddress 3 "1DzqBck9oyCBzxJbbje2s15deZis6BeATi"
```