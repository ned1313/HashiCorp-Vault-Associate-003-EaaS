# Create a base64 encoded string to encrypt
$base64String = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("Super secret sauce recipe!!"))

# Submit the base64 encoded string to the transit secrets engine for encryption
vault write transit/encrypt/taco-app plaintext=$base64String

# Decrypt the data using the transit secrets engine
vault write transit/decrypt/taco-app ciphertext="CIPHERTEXT_HERE"

# Decode the decrypted base64 string
[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String("DECRYPTED_BASE64_STRING_HERE"))

