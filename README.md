# Dapp Demo
A example of a decentralized app that utilizes a smart contract to transfer funds ([link to slides with instructions/solutions](https://docs.google.com/presentation/d/15LqMhebc0wOZNEtneU-mZjJ-r1l-Z9bLvIgNk2d8ePU/edit?usp=sharing)).

## Setup

Make sure you have [Node](https://nodejs.org), the [Metamask](https://metamask.io/) extension, and [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) installed.

Set up Metamask by creating a wallet. This should ask you to create a password and keep a mnemonic seed phrase saved. Keep this phrase private for any wallet you'd like to use to handle real funds.

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

![Video demonstration of a KatCoin purchase](https://youtu.be/9ASbelpozfA)
