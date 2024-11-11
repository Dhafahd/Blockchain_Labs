// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SocialMedia {
    struct Post {
        uint256 id;
        address author;
        string content;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
        uint256 modifiedAt;
    }

    Post[] public posts;
    mapping(address => uint256[]) public userPosts;
    mapping(uint256 => mapping(address => bool)) public postLiked;    // Tracks if a user has liked a post
    mapping(uint256 => mapping(address => bool)) public postDisliked; // Tracks if a user has disliked a post
    uint256 public postCount;

    event PostCreated(uint256 indexed postId, address indexed author, string content, uint256 createdAt);
    event PostUpdated(uint256 indexed postId, string newContent, uint256 modifiedAt);
    event PostDeleted(uint256 indexed postId, address indexed author);
    event PostLiked(uint256 indexed postId, uint256 newLikeCount);
    event PostDisliked(uint256 indexed postId, uint256 newDislikeCount);

    function createPost(string memory content) public {
        Post memory newPost = Post({
            id: postCount,
            author: msg.sender,
            content: content,
            likes: 0,
            dislikes: 0,
            createdAt: block.timestamp,
            modifiedAt: 0
        });
        posts.push(newPost);
        userPosts[msg.sender].push(postCount);
        emit PostCreated(postCount, msg.sender, content, block.timestamp);
        postCount++;
    }

    function getPost(uint256 postId) public view returns (Post memory) {
        require(postId < postCount, "Post does not exist");
        return posts[postId];
    }

    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }

    function editPost(uint256 postId, string memory newContent) public {
        require(postId < postCount, "Post does not exist");
        Post storage post = posts[postId];
        require(msg.sender == post.author, "Only the author can edit this post");

        post.content = newContent;
        post.modifiedAt = block.timestamp;
        emit PostUpdated(postId, newContent, block.timestamp);
    }

    function deletePost(uint256 postId) public {
        require(postId < postCount, "Post does not exist");
        Post storage post = posts[postId];
        require(msg.sender == post.author, "Only the author can delete this post");

        delete posts[postId];
        emit PostDeleted(postId, msg.sender);
    }

    function likePost(uint256 postId) public {
        require(postId < postCount, "Post does not exist");
        require(!postLiked[postId][msg.sender], "You have already liked this post");

        Post storage post = posts[postId];
        post.likes++;
        postLiked[postId][msg.sender] = true;
        emit PostLiked(postId, post.likes);
    }

    function dislikePost(uint256 postId) public {
        require(postId < postCount, "Post does not exist");
        require(!postDisliked[postId][msg.sender], "You have already disliked this post");

        Post storage post = posts[postId];
        post.dislikes++;
        postDisliked[postId][msg.sender] = true;
        emit PostDisliked(postId, post.dislikes);
    }
}
