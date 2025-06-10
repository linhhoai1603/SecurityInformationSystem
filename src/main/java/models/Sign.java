package models;

import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class Sign {
    private PublicKey publicKey;
    private PrivateKey privateKey;
    public static final String algorithm = "RSA";

    public byte[] signBytes(String data, String privateKey) throws Exception {
        this.privateKey = stringToPrivateKey(privateKey);
        Signature s = Signature.getInstance(algorithm);
        s.initSign(this.privateKey);
        s.update(data.getBytes());
        return s.sign();
    }

    public String sign(String data, String privateKey) throws Exception {
        byte[] sign = signBytes(data, privateKey);
        return Base64.getEncoder().encodeToString(sign);
    }

    public boolean verify(String data, String signBase64, String publicKey) throws Exception {
        this.publicKey = stringToPublicKey(publicKey);
        Signature s = Signature.getInstance(algorithm);
        s.initVerify(this.publicKey);
        s.update(data.getBytes());
        return s.verify(Base64.getDecoder().decode(signBase64));
    }

    public PublicKey stringToPublicKey(String publicKeyString) throws Exception {
        // Loại bỏ header và footer của PEM format nếu có
        String cleanKey = publicKeyString
                .replace("-----BEGIN PUBLIC KEY-----", "")
                .replace("-----END PUBLIC KEY-----", "")
                .replaceAll("\\s", ""); // Loại bỏ tất cả whitespace

        // Decode Base64
        byte[] keyBytes = Base64.getDecoder().decode(cleanKey);

        // Tạo PublicKey từ byte array
        X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(algorithm);
        return keyFactory.generatePublic(spec);
    }

    // Hàm chuyển String privateKey thành PrivateKey
    public PrivateKey stringToPrivateKey(String privateKeyString) throws Exception {
        // Loại bỏ header và footer của PEM format nếu có
        String cleanKey = privateKeyString
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replace("-----BEGIN RSA PRIVATE KEY-----", "")
                .replace("-----END RSA PRIVATE KEY-----", "")
                .replaceAll("\\s", ""); // Loại bỏ tất cả whitespace

        // Decode Base64
        byte[] keyBytes = Base64.getDecoder().decode(cleanKey);

        // Tạo PrivateKey từ byte array
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(algorithm);
        return keyFactory.generatePrivate(spec);
    }

    public static void main(String[] args) {
        String hashOrder = "PBKDF2WithHmacSHA256HELLO";
        String publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsiywZHVOuCCppwDtYoCMWptQqkonFOePJQRD9Qelyz3YQBBvLm1pTFL28zBydFP9li8Qk8QTEplDFHTmz+dtsZ33foKhMgH/y4w/9kZMJ4uSmkCWxHgnyCc6zokaA3bfb0Y0e30v4kxAGrtS0lbz0v5aDCbxab9nhRc8jucSdU6PFOMAMdiw2X7u/E4QDjuJYdj7ThzghrZI3eX08tGfBVNqEupDDJG5Az1+Isc3g5nHw2F1n9EeyfY0go0TkaTQb8kYiJ3n5TBl4DseY+/wKb66geOoMZIfKFhoI0v2GmUt5pLMJG8VeZniM37+1Ht8nyhfnK2z7X2A9fAQ9DRRNQIDAQAB";


    }
}
