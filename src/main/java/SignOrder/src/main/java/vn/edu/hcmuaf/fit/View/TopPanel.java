package vn.edu.hcmuaf.fit.View;

import vn.edu.hcmuaf.fit.Model.Value;

import javax.swing.*;

import java.awt.*;

import static vn.edu.hcmuaf.fit.Model.Value.KEYSIZE_RSA;

public class TopPanel extends JPanel {
    public JComboBox<Integer> rsa_keysize_cb;
    public JComboBox<String> sign_algo_cb;
    public JPanel panel_top, panel_bottom;
    public JTabbedPane panel_tabbed;
    public JButton loadPrivateKey_btn, loadPublicKey_btn, savePrivateKey_btn, savePublicKey_btn, genKey_btn;
    public JTextField privateKey, publicKey;

    public TopPanel() {
        setLayout(new BorderLayout());
        //select keysize and signature algorithm for generate key
        panel_top = new JPanel();
        panel_top.setLayout(new GridLayout(1, 2));
        panel_top.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        rsa_keysize_cb = new JComboBox<>(KEYSIZE_RSA);
        rsa_keysize_cb.setSelectedIndex(0);
        rsa_keysize_cb.setBorder(BorderFactory.createTitledBorder("RSA Key Size"));
        panel_top.add(rsa_keysize_cb);

        sign_algo_cb = new JComboBox<>(Value.SIGN_ALGO);
        sign_algo_cb.setSelectedIndex(0);
        sign_algo_cb.setBorder(BorderFactory.createTitledBorder("Sign Algorithm"));
        panel_top.add(sign_algo_cb);
        //execute generate key
        panel_bottom = new JPanel(new GridLayout(1, 3));
        panel_bottom.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        panel_tabbed = new JTabbedPane();
        panel_bottom.add(panel_tabbed);

        JPanel panel_generateKey = new JPanel(new GridLayout(1, 1));
        genKey_btn = new JButton("Generate Key");
        panel_generateKey.add(genKey_btn);
        panel_tabbed.add(panel_generateKey, "Generate Key");

        JPanel panel_loadKey = new JPanel(new GridLayout(2, 1));
        loadPrivateKey_btn = new JButton("Load Private Key");
        loadPublicKey_btn = new JButton("Load Public Key");
        panel_loadKey.add(loadPrivateKey_btn);
        panel_loadKey.add(loadPublicKey_btn);
        panel_tabbed.add(panel_loadKey, "Load Key");

        JPanel panel_bottom_1 = new JPanel(new GridLayout(2, 1));
        privateKey = new JTextField(20);
        privateKey.setBorder(BorderFactory.createTitledBorder("Private Key"));
        privateKey.setBackground(new Color(238, 238, 238));
        privateKey.setEditable(false);
        publicKey = new JTextField(20);
        publicKey.setBorder(BorderFactory.createTitledBorder("Public Key"));
        publicKey.setBackground(new Color(238, 238, 238));
        publicKey.setEditable(false);
        panel_bottom_1.add(privateKey);
        panel_bottom_1.add(publicKey);
        panel_bottom.add(panel_bottom_1);

        JPanel panel_bottom_2 = new JPanel(new GridLayout(2, 1));
        savePrivateKey_btn = new JButton("Save Private Key");
        savePublicKey_btn = new JButton("Save Public Key");
        panel_bottom_2.add(savePrivateKey_btn);
        panel_bottom_2.add(savePublicKey_btn);
        panel_bottom.add(panel_bottom_2);

        add(panel_top, BorderLayout.NORTH);
        add(panel_bottom, BorderLayout.CENTER);
    }
}
