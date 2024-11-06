// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MiniSocial {
    // Déclaration de la structure Post avec un identifiant unique
    struct Post {
        uint id;
        string message;
        address author;
    }

    // Tableau dynamique pour stocker tous les messages
    Post[] public posts;
    
    // Comptage des identifiants de messages
    uint public postCount;

    // Événement pour notifier la publication d'un nouveau message
    event PostPublished(uint indexed id, string message, address indexed author);

    // Fonction pour publier un message
    function publishPost(string memory _message) public {
        // Vérifie que le message n'est pas vide
        require(bytes(_message).length > 0, "Le message ne peut pas etre vide");

        // Création d'un nouveau Post avec un identifiant unique
        posts.push(Post(postCount, _message, msg.sender));
        emit PostPublished(postCount, _message, msg.sender);
        postCount++;
    }

    // Fonction pour consulter un message par index
    function getPost(uint _index) public view returns (uint, string memory, address) {
        require(_index < posts.length, "Index hors limites");
        Post storage post = posts[_index];
        return (post.id, post.message, post.author);
    }

    // Fonction pour récupérer le nombre total de messages publiés
    function getTotalPosts() public view returns (uint) {
        return posts.length;
    }

    // Fonction pour obtenir tous les posts
    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }
}
