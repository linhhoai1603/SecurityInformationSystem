package vn.edu.hcmuaf.fit.View;

import javax.swing.*;
import java.awt.*;

public class BottomPanel extends JPanel {
    public JButton sign_btn, saveSign_btn, copySign_btn;
    public JButton verify_btn, loadSign_btn;
    public JButton loadFile_sign_btn, loadFile_verify_btn;

    public BottomPanel() {
        setLayout(new BorderLayout());
        setBorder(BorderFactory.createEmptyBorder(0, 10, 10, 10));
        JTabbedPane tabbedPane = new JTabbedPane();
        loadFile_sign_btn = new JButton("Load File");

        JPanel sign_panel = new JPanel();
        sign_panel.setLayout(new GridLayout(1, 4));
        sign_panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        sign_btn = new JButton("Sign");
        saveSign_btn = new JButton("Save Signature");
        copySign_btn = new JButton("Copy Signature");

        sign_panel.add(sign_btn);
        sign_panel.add(saveSign_btn);
        sign_panel.add(copySign_btn);
        sign_panel.add(loadFile_sign_btn);

        JPanel verify_panel = new JPanel();
        verify_panel.setLayout(new GridLayout(1, 3));
        verify_panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        verify_btn = new JButton("Verify");
        loadSign_btn = new JButton("Load Signature");
        loadFile_verify_btn = new JButton("Load File");

        verify_panel.add(verify_btn);
        verify_panel.add(loadSign_btn);
        verify_panel.add(loadFile_verify_btn);

        tabbedPane.add(sign_panel, "Signature");
        tabbedPane.add(verify_panel, "Verify");
        add(tabbedPane);
    }
}
