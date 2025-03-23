#!/bin/bash

# Add AWS secrets patterns
git secrets --register-aws

# Add OpenAI API key pattern (starts with 'sk-' followed by alphanumeric characters)
git secrets --add 'sk-[a-zA-Z0-9]{20,}'

# Add SSH private key patterns
git secrets --add '-----BEGIN (OPENSSH|RSA) PRIVATE KEY-----'

# Add SSH public key pattern (optional)
git secrets --add 'ssh-(rsa|ed25519) AAAA[0-9A-Za-z+/]+[=]{0,3}'

echo "Git Secrets patterns have been configured."
