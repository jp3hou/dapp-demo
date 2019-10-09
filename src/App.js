import React from "react";
import styled from "styled-components";

import HeaderBar from "./components/HeaderBar";
import Cat from "./components/Cat";

class App extends React.Component {
  constructor() {
    super();

    const Kats = window.web3.eth.contract(
      [
	{
		"constant": true,
		"inputs": [
			{
				"name": "katId",
				"type": "uint256"
			}
		],
		"name": "ownerOf",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "owner",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "katId",
				"type": "uint256"
			}
		],
		"name": "getKat",
		"outputs": [
			{
				"name": "color",
				"type": "uint32"
			},
			{
				"name": "generation",
				"type": "uint16"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "katId",
				"type": "uint256"
			}
		],
		"name": "purchase",
		"outputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "katId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "genes",
				"type": "uint256"
			}
		],
		"name": "Minted",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "from",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "to",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "katId",
				"type": "uint256"
			}
		],
		"name": "Sent",
		"type": "event"
	}
]    );

    this.state = {
      kats: Kats.at(
        // CONTRACT ADDRESS GOES HERE
      ),
      loading: true,
      cats: []
    };
  }

  componentDidMount = async () => {
    const { kats } = this.state;
    for (let i = 0; i < 30; i++)
      kats.getKat(i, (err, cat) =>
        kats.ownerOf(i, (err, owner) =>
          this.setState(state => ({
            cats: [
              ...state.cats,
              {
                color: `#${cat[0].toString(16).padStart(6, "0")}`,
                id: i,
                generation: cat[1].toString(),
                owner: owner
              }
            ]
          }))
        )
      );
  };

  handlePurchase = id => {
    this.state.kats.purchase(id, (err, result) => {
      alert('success!');
    });
  };

  render() {
    const { cats } = this.state;
    return (
      <div>
        <HeaderBar>
          <h1>
            KatCoins
          </h1>
        </HeaderBar>
        <main>
          <CatWrapper>
            {cats.map(cat => (
              <Cat {...cat} onClick={this.handlePurchase} />
            ))}
          </CatWrapper>
        </main>
      </div>
    );
  }
}

const CatWrapper = styled.div`
  display: flex;
  margin: -8px;
  flex-wrap: wrap;
`;

export default App;
