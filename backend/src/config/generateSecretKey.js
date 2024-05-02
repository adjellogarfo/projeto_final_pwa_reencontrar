// generateSecretKey.js
import crypto from "crypto";

// Generate a random secret key (32 bytes) at runtime
//const secretKey = crypto.randomBytes(32).toString('hex');
const secretKey = "10c7d42b42b978d5ed989bca6075c009a205db6a44ac9d21406506ef9dde6582";

//console.log('Generated Secret Key:', secretKey);

export { secretKey };
