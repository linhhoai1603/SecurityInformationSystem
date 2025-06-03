package vn.edu.hcmuaf.fit.Model;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Arrays;
import java.util.Base64;

public class DS {
    private PublicKey publicKey;
    private PrivateKey privateKey;

    public void genKey(int keySize) throws Exception {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(keySize);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();
        publicKey = keyPair.getPublic();
        privateKey = keyPair.getPrivate();
    }

    public PrivateKey loadPrivateKey(String path) throws Exception {
        byte[] base64Bytes;
        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path))) {
            base64Bytes = bis.readAllBytes();
        }
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(base64Bytes));
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePrivate(keySpec);
    }

    public PublicKey loadPublicKey(String path) throws Exception {
        byte[] base64Bytes;
        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path))) {
            base64Bytes = bis.readAllBytes();
        }
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(base64Bytes));
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePublic(keySpec);
    }

    private void saveKeyToFile(String path, byte[] keyBytes) throws Exception {
        String base64 = Base64.getEncoder().encodeToString(keyBytes);
        byte[] base64Bytes = base64.getBytes(StandardCharsets.UTF_8);

        try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(path))) {
            bos.write(base64Bytes);
        }
    }

    public void saveKey(String path, boolean isPrivateKey) throws Exception {
        if (isPrivateKey) saveKeyToFile(path, this.privateKey.getEncoded());
        else saveKeyToFile(path, this.publicKey.getEncoded());
    }

    public byte[] signBytes(String data, String algo) throws Exception {
        Signature s = Signature.getInstance(algo);
        s.initSign(this.privateKey);
        s.update(data.getBytes());
        return s.sign();
    }

    public String sign(String data, String algo) throws Exception {
        byte[] sign = signBytes(data, algo);
        return Base64.getEncoder().encodeToString(sign);
    }

    //dung de luu sign duoi dang base64 thanh file txt, file giu nguyen base64 khi luu.
    //khi loadfile/loadsign, sign textarea duoc load len la dinh dang base64
    public void saveSign(String path, String signBase64) throws IOException {
        try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(path))) {
            byte[] data = signBase64.getBytes(StandardCharsets.UTF_8);
            bos.write(data);
        }
    }

    //dung de load file don gian tu path sang text. chi nhan file txt, txt la hashvalue cua don hang
    public String loadFile(String path) throws Exception {
        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path));
             ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
            byte[] data = new byte[1024];
            int bytesRead;

            while ((bytesRead = bis.read(data)) != -1) {
                buffer.write(data, 0, bytesRead);
            }

            return buffer.toString(StandardCharsets.UTF_8);
        }
    }

    public byte[] signFileBytes(String path, String algo) throws IOException, NoSuchAlgorithmException, InvalidKeyException, SignatureException {
        Signature s = Signature.getInstance(algo);
        s.initSign(this.privateKey);
        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path));
        byte[] buffer = new byte[1024];
        int read;
        while ((read = bis.read(buffer)) != -1) {
            s.update(buffer, 0, read);
        }
        return s.sign();
    }

    public String signFile(String path, String algo) throws Exception {
        byte[] sign = signFileBytes(path, algo);
        return Base64.getEncoder().encodeToString(sign);
    }

    public boolean verify(String data, String signBase64, String algo) throws Exception {
        Signature s = Signature.getInstance(algo);
        s.initVerify(this.publicKey);
        s.update(data.getBytes());
        return s.verify(Base64.getDecoder().decode(signBase64));
    }

    public boolean verifyFile(String path, String sign, String algo) throws Exception {
        Signature s = Signature.getInstance(algo);
        s.initVerify(this.publicKey);
        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path));
        byte[] buffer = new byte[1024];
        int read;
        while ((read = bis.read(buffer)) != -1) {
            s.update(buffer, 0, read);
        }
        return s.verify(Base64.getDecoder().decode(sign));
    }

    public PublicKey getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(PublicKey publicKey) {
        this.publicKey = publicKey;
    }

    public PrivateKey getPrivateKey() {
        return privateKey;
    }

    public void setPrivateKey(PrivateKey privateKey) {
        this.privateKey = privateKey;
    }

}
