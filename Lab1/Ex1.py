import hashlib

# Constants for direction
LEFT = 'left'
RIGHT = 'right'

# Sample leaf hashes
leaves = [
    'leaf1',
    'leaf2',
    'leaf3',
    'leaf4',
    'leaf5',
    'leaf6'
]

# Function to hash data using SHA-256
def sha256(data):
    return hashlib.sha256(data.encode('utf-8')).hexdigest()

# Ensure the array length is even by duplicating the last element if necessary
def ensure_even_length(hashes):
    if len(hashes) % 2 != 0:
        hashes.append(hashes[-1])

# Generate the Merkle root from the leaf hashes
def generate_merkle_root(hashes):
    if not hashes or len(hashes) == 0:
        return ''
    
    ensure_even_length(hashes)
    combined_hashes = []

    for i in range(0, len(hashes), 2):
        combined_hash = sha256(hashes[i] + hashes[i + 1])
        combined_hashes.append(combined_hash)

    return combined_hashes[0] if len(combined_hashes) == 1 else generate_merkle_root(combined_hashes)

# Generate the Merkle tree structure
def generate_merkle_tree(hashes):
    tree = [hashes]
    current_level = hashes

    while len(current_level) > 1:
        ensure_even_length(current_level)
        next_level = []

        for i in range(0, len(current_level), 2):
            combined_hash = sha256(current_level[i] + current_level[i + 1])
            next_level.append(combined_hash)
        
        tree.append(next_level)
        current_level = next_level

    return tree

# Generate a Merkle proof for a given hash
def generate_merkle_proof(hash_value, hashes):
    tree = generate_merkle_tree(hashes)
    proof = []
    hash_index = tree[0].index(hash_value)

    if hash_index == -1:
        return None  # Hash not found

    for level in range(len(tree) - 1):
        is_left_child = hash_index % 2 == 0
        sibling_index = hash_index + 1 if is_left_child else hash_index - 1
        sibling_hash = tree[level][sibling_index]

        proof.append({
            'hash': sibling_hash,
            'direction': RIGHT if is_left_child else LEFT
        })

        hash_index //= 2

    return proof

# Verify a Merkle proof against a given root
def verify_merkle_proof(leaf, proof, root):
    hash_value = sha256(leaf)

    for p in proof:
        proof_hash = p['hash']
        direction = p['direction']
        hash_value = sha256(proof_hash + hash_value) if direction == LEFT else sha256(hash_value + proof_hash)

    return hash_value == root

# Example execution
hashed_leaves = list(map(sha256, leaves))
merkle_root = generate_merkle_root(hashed_leaves)
proof = generate_merkle_proof(sha256(leaves[4]), hashed_leaves)
tree = generate_merkle_tree(hashed_leaves)

# Calculate root from proof
if proof:
    root_from_proof = sha256(leaves[4])
    for p in proof:
        root_from_proof = sha256(p['hash'] + root_from_proof) if p['direction'] == LEFT else sha256(root_from_proof + p['hash'])
else:
    root_from_proof = None

# Output the results
print('Merkle Root:', merkle_root)
print('Generated Merkle Proof:', proof)
print('Merkle Tree:', tree)
print('Root from Merkle Proof:', root_from_proof)
print('Proof Validity:', root_from_proof == merkle_root)
