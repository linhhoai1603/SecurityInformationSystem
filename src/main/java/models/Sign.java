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
    public static final String ALGORITHM_SIGN = "SHA256withRSA";
    public static final String ALGORITHM_KEY = "RSA";


    public byte[] signBytes(String data, String privateKey) throws Exception {
        this.privateKey = stringToPrivateKey(privateKey);
        Signature s = Signature.getInstance(ALGORITHM_SIGN);
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
        Signature s = Signature.getInstance(ALGORITHM_SIGN);
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
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM_KEY);
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
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM_KEY);
        return keyFactory.generatePrivate(spec);
    }

    public static void main(String[] args) throws Exception {
        Sign signer = new Sign();

        String hashOrder = "01ae89ba7cd9a449078d43c6a392d9eb81abf8915e9e08077febf251d0d2c152";
        String publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApmAMDyCNwegigHC2O35KhzG8Jh1wKu2R8UGjjE7rNLvXwekJXlunJ4v90+/8bUDRHwdAlpzxWcqYvnUxCEygAp2Bet6hqKDPZgYipdfiHanHGzpUI63YU1tEnZsei82AqkED0C85B4Lsr7nPVrAKcUsauSgz2CG/3u3f6Rv02QkPqOCRHNE760nRGNB7OwWTt1nZRo8GCQ1OExiiz0m9l+7ep3H01vWF4bLcm8LZaqZPEJBY7EmXq/l/0GL1I6y3E+U02PVRj9EhW9A5z+xmRxa2f6DooIvRiHkSRsjfdgYXoNnA0Mwey715kgO1Um524voxDNKDBBeoRJJKCszxuQIDAQAB";
//        String privateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCmYAwPII3B6CKAcLY7fkqHMbwmHXAq7ZHxQaOMTus0u9fB6QleW6cni/3T7/xtQNEfB0CWnPFZypi+dTEITKACnYF63qGooM9mBiKl1+IdqccbOlQjrdhTW0Sdmx6LzYCqQQPQLzkHguyvuc9WsApxSxq5KDPYIb/e7d/pG/TZCQ+o4JEc0TvrSdEY0Hs7BZO3WdlGjwYJDU4TGKLPSb2X7t6ncfTW9YXhstybwtlqpk8QkFjsSZer+X/QYvUjrLcT5TTY9VGP0SFb0DnP7GZHFrZ/oOigi9GIeRJGyN92Bheg2cDQzB7LvXmSA7VSbnbi+jEM0oMEF6hEkkoKzPG5AgMBAAECggEAAMwRArmLNFSiZa8kkGBohwFL/3rAoNQGkPtZh0CRi+0ieYFeVB9oS542Fx/dO8DFv7pPKumRlnaMCM2S8JE9awXKKwaKC77Jf5mj7Nt979pyY8UBxjH9CVk0mPS3TsArT6WEGSlAwrJz49umDKpHQoezlxOEPBLdUnodSoahw7BvcdrRBp+dx9Nx8/9RopgUmSiBVYO9z5ZmLwnLnH3TvbyTtnmOtA5EKQBmpUwxfR5l0lZk3eLJeSxsBD37WDMWo8qCFMYv5laE225xmDuqC3zYl463rKwOabx/TxRBPhrSns9p7Zt31jadm0VD6yXQJVfxgG6L402dxCl2R6KnAQKBgQDZEO3zQxHg9oiqzNDaQoTlYfVl9u+5oFRxAl1ADguOwbU+CjdTqYOFbZOuUpWgk5BltTeMxaQxFzdZicR/ArNWEJPq0GQ6ykyCNeHRHq8eGIC08AD1JdY4tMlCSknZPS/qPUkI2FgzsEDHCuoXUXqzrgKz/Bn8e3EFl7AzKwAlCQKBgQDEN4fpUEF4wtaG9IqG89fChWjw2VgaaI0GSdGvKG1Hpq3Y06IGlqRfn7CW42WmpkLNCaRz3y7kKttEtyE+ipvAf++PGkjLVkw1M4u87iy/5760mFczkcHBwqOL2Pqvgii+zyfCjVPCmk2Ov3WXJQsqnuGaHBh3+zH+KxEECxDDMQKBgCqARhb7auTBYMEQmVQi8iJ3q7TrRMTzv5ThAaEpHto002fyWCLpbfcSHXhkcyedvQgtE1Nc32k9QnkloHO9859GX6/6XaWlNpXINw7bEy6xXYIP/CAD6I3x1/ZC1XLTqC4VEdfJhHuaZxSR7oPiUEQeLilPk0b8ZITTzow2PzEBAoGAcW4gtbHdh3ArEC1B/63rJtp0xfb/RZT3IZF/FCDsu6URju0ZF3HyaA0qyq9+Tg6DQ4C1fv6gXuqfg2PSZhM+4tOSq0lol5O1znOT7o5JdE8GIeSHVJqIRfi9DtVKZjd6UoPy2jdVGoSVHVZ1JgEWKXdbt/lR89pVFjfTSGEVOaECgYEAjsyGNW5EEwy/g86X23jRFWiF8ztfD87y73mcED6sxn5BfOG6gYOtapw5aQn/6z747GXrc0V+BED3kJ/H6DuMijelkqiZ/FWCk5aNzcZ8u+wNg9t6txGL/JRWXclZ8wlYFGi6KcF4x7oBPo8Xqkv7ZfwBbxlbXMSt4IqrRf6uJDs=";
//        String base64Sign = signer.sign(hashOrder, privateKey);
//        System.out.println(base64Sign);

//      Chữ ký từ web
        String base64Sign = "N/hzqfjUvo+j2J3kdR22PUq4eBbFYm3z6Bf36TDBtKXO2UoA2HhNFP+CHZa62wzz7MmRBW/DvA0oiIuYhP3i9NjbduJp6Mmr/LeYD1dhmY0Gxb7V6+4uUVudZXxbQOQK5UJXaBoewg9Hk5yTcRjiHvpx4TvmqXAcoYPDcKa5rC1cSV+6RTETOBwZCQ9cyslQLXj50xjV6WMg08njZ8Q+M1JC2Wc3ftCOZP8TTKcAcVN5Qp73bPJU3vj79KC0cII1N37w+c66ZGC/1XOzZCFwPDa7E5HQm5QxuXDSsyk0BFik4+isSteCl1eq2AAFFC21RfoqP/y/uNzOWiXodEtPoQ==";

        System.out.println(signer.verify(hashOrder, base64Sign, publicKey));

    }
}
