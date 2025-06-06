package models;

import javax.crypto.Cipher;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class RSA {

    /**
     * Verifies an RSA digital signature.
     *
     * @param dataString The original data (or its hash) as a String.
     * @param signatureBase64 The digital signature encoded in Base64 format as a String.
     * @param publicKeyBase64 The public key encoded in Base64 format as a String.
     * @return true if the signature is valid, false otherwise.
     */
    public static boolean verifySignature(String dataString, String signatureBase64, String publicKeyBase64) {
        try {
            // 1. Decode the Base64 public key string
            byte[] publicKeyBytes = Base64.getDecoder().decode(publicKeyBase64);

            // 2. Decode the Base64 signature string
            byte[] signatureBytes = Base64.getDecoder().decode(signatureBase64);

            // 3. Convert the data string to bytes
            //    Assuming UTF-8 encoding for the data string. Adjust if necessary.
            byte[] dataBytes = dataString.getBytes("UTF-8");

            // 4. Create a KeyFactory for RSA
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");

            // 5. Create an X509EncodedKeySpec from the public key bytes
            X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyBytes);

            // 6. Generate the PublicKey object
            PublicKey publicKey = keyFactory.generatePublic(publicKeySpec);

            // 7. Create a Signature object (using the same algorithm as signing)
            //    Assuming SHA256withRSA was used for signing. Adjust if necessary.
            Signature verifier = Signature.getInstance("SHA256withRSA");

            // 8. Initialize the Signature object with the public key
            verifier.initVerify(publicKey);

            // 9. Update the Signature object with the data to be verified
            verifier.update(dataBytes);

            // 10. Verify the signature
            return verifier.verify(signatureBytes);

        } catch (NoSuchAlgorithmException | InvalidKeySpecException | InvalidKeyException | SignatureException e) {
            // Log the exception or handle it as appropriate for your application
            e.printStackTrace();
            System.err.println("Error during signature verification: " + e.getMessage());
            return false; // Verification failed due to an error
        } catch (IllegalArgumentException e) {
            // Handle invalid Base64 string for either public key or signature
            e.printStackTrace();
            System.err.println("Error decoding Base64 string: " + e.getMessage());
            return false;
        } catch (Exception e) { // Catch other potential exceptions, e.g., UnsupportedEncodingException for getBytes
            e.printStackTrace();
            System.err.println("An unexpected error occurred: " + e.getMessage());
            return false;
        }
    }

    public static boolean verifyWithPublicKey(String publicKeyStr, String cipherText, String plainText) throws Exception {
        // Chuyển chuỗi publicKey sang đối tượng PublicKey
        byte[] publicBytes = Base64.getDecoder().decode(publicKeyStr);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PublicKey publicKey = keyFactory.generatePublic(keySpec);

        // Tạo Cipher và thiết lập ở chế độ DECRYPT_MODE với public key
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, publicKey);

        // Giải mã văn bản mã hóa
        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(cipherText));
        return new String(decryptedBytes).equals(plainText);
    }

    public static void main(String[] args) throws Exception {
        String publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArNIHz7JN85ASjGuDvv3R2YJ407xjXeT3bqdwlsq4+um9r/Isuo+ReGhiO3MDaeMeZtxlNj1PWKfJd5W9r94NTnAcvQKE6yhNItjfqawwoWW/gN8CU6Cwy69MiJtjloS0cQ36Mbs2Hn2nWg6yo7/vdsKEosjINQrWj9cPu+KUw8VWHzBtG//Cvj+TMbmg/NFpJ3yrx5BVU4HFwggcjC1+y1M5jSeqmoW04JWFPD0npPt+01EqwKq45FOQrX5oedjtcFjLaBGKj4euLlKWqKIyDh4Pw8kbPFqqtIlLJ5S8swyiy73mvrUoj8NmOrfEKnSQ3bmU6cFE5i5sSAskoENYUQIDAQAB";
        String signature = "YmdEmkguUyqhm4jOcsfkLXsN2HEmB0dFGznOJgu2dhi+c/y7G4unW3htm9Vm2eHJWE8mWHhKm0U4bB2ILc1+jp6OQBfCa+pcwXdUasjZA+2wRF9+zMQD4E/r0dJKYYX4lHrJSWXmIBYfNg1ieRRlX242On1ra2IPqsoolZerXA9KQx+XrC4WD7yB2z1AhOojhw/2sIcpL19lzeZLN+cjlkVQ6Benhe6jl0pu6xi9ws2KO+6N4sdcUKrHKNmRQxKzNHGMTpRFlfwwhiM0VAt2KmVGWWObDxqe0H0Zy0p4kmDBjzVuwuTjxIKpwxUhsRKkJ0HZT5BjI3kqPE1pC3GOag==";
        String jsonHash = "3229d6cb4dd9c0437aaf7dd3e1535d6221c261f3424451e8d3aefec6e34e966a";

        RSA rsa = new RSA();
        boolean ok = RSA.verifyWithPublicKey(publicKey, signature, jsonHash);
        System.out.println(ok);
    }

}
