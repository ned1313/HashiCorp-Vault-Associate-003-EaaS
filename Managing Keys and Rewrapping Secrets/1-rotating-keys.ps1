# Check out the current version of the taco-app key
vault read transit/keys/taco-app

# Encrypt a string using the Vault Transit Secrets Engine
$base64String = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("Super secret sauce recipe!!"))

$v1ciphertext=$(vault write -field ciphertext transit/encrypt/taco-app plaintext=$base64String)

$v1ciphertext

# Rotate the taco-app key
vault write -f transit/keys/taco-app/rotate

# Encrypt the same string again using the Vault Transit Secrets Engine
vault write -field ciphertext transit/encrypt/taco-app plaintext=$base64String

# Decrypt the data using the transit secrets engine
vault write -field plaintext transit/decrypt/taco-app ciphertext=$v1ciphertext

# Change the min_decryption_version to 4
vault write transit/keys/taco-app/config min_decryption_version=4

# Rotate the taco-app key again
vault write -f transit/keys/taco-app/rotate

# Rewrap the v5 ciphertext to the latest key
vault write -field ciphertext transit/rewrap/taco-app ciphertext="V5CIPHERTEXT_HERE"