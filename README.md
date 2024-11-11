# Mini Social Media Platform

This repository contains the code for a decentralized social media platform built using Solidity smart contracts and Ethereum blockchain technology. The platform allows users to create, edit, delete, like, and dislike posts on the blockchain, providing an immutable and transparent record of interactions.

## Key Features

- **Decentralized platform**: All data (posts, likes, dislikes) is stored on the Ethereum blockchain.
- **Smart contract**: Handles post creation, editing, deletion, and user interactions.
- **Frontend**: Built with HTML, CSS, JavaScript, and Web3.js to interact with the blockchain.
- **MetaMask**: For managing user accounts and transactions.

## Components

1. **Solidity Smart Contract**:
   - Handles the storage and management of posts.
   - Functions for creating, editing, deleting, liking, and disliking posts.
   - Emits events on actions (PostCreated, PostUpdated, PostDeleted, PostLiked, PostDisliked).

2. **Frontend Application**:
   - Allows users to view posts, create new posts, like or dislike posts, and interact with the contract.
   - Built using Web3.js for blockchain interaction.

3. **MetaMask Integration**:
   - MetaMask is used for account management and signing transactions.

## How It Works

### Smart Contract Functions

- **createPost**: Users can create new posts by submitting content.
- **editPost**: Users can edit their posts.
- **deletePost**: Users can delete their own posts.
- **likePost**: Users can like posts.
- **dislikePost**: Users can dislike posts.
- **getPost**: Retrieve specific posts.
- **getAllPosts**: Retrieve all posts.

### Frontend Features

- **View Posts**: All posts are displayed to the user.
- **Create Post**: Users can create posts with custom content.
- **Like/Dislike**: Users can like or dislike posts.
- **Edit/Delete**: Users can edit or delete their posts.
  
### Error Handling

- Checks if MetaMask is installed.
- Handles errors during post creation, likes/dislikes, and edits.
- Displays alerts for unauthorized actions (e.g., editing or deleting other users' posts).

## Installation

### Prerequisites

- [Node.js](https://nodejs.org/) (for running the frontend)
- [MetaMask](https://metamask.io/) (for managing Ethereum accounts)
- [Solidity](https://soliditylang.org/) (to deploy the smart contract)
- [Ganache](https://www.trufflesuite.com/ganache) (optional for local Ethereum blockchain)

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/mini-social-media.git
   cd mini-social-media
