# Dapp Demo
A example of a decentralized app that utilizes a smart contract to transfer funds ([link to slides with instructions/solutions](https://docs.google.com/presentation/d/1Yu9yTOsuy1EG4g5UoZKeoxxTpO3AbRJ8NOpTB8MxFbY/edit?usp=sharing)).

## Setup

Make sure you have [Node](https://nodejs.org), the [Metamask](https://metamask.io/) extension, and [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) installed.

1. Clone the repo

```
$ git clone https://github.com/jp3hou/dapp-demo
$ cd dapp-demo
```

2. Install dependencies using npm

```
$ npm install
```

3. Compile the smart contracts with truffle

```
$ npm run compile
```

4. Run a local blockchain server using ganache

```
$ npm run blockchain
```

5. Deploy smart contracts onto your blockchain server

```
$ npm run migrate
```
6. Start your frontend server

```
$ npm run start
```

Open your browser to http://localhost:3000 to see your local environment!
The constructor in the KatCoin.sol contract auto-mints 30 KatCoins and displays them in the frontend React app.
![Screenshot](/screenshots/kats_home.png?raw=true)

Find the address of your wallet in Metamask:
![Screenshot](/screenshots/metamask.png?raw=true)

(Click the address to copy it to your clipboard)

Set the default web3 address to your wallet address

```
$ web3.eth.defaultAccount = "[Your address]"
```

Click on one of the cats to see the success message! You've successfully purchased one of the KatCoins!
![Screenshot](/screenshots/successful_purchase.png?raw=true)

![Video demo of importing your local account to Metamask](https://youtu.be/60M7Kq_mrFE)
