package vn.edu.hcmuaf.fit.View;

import javax.swing.*;
import java.awt.*;

public class CenterPanel extends JPanel {
    public JTextArea text_area, sign_textField;

    public CenterPanel() {
        setLayout(new BorderLayout(10, 10));
        setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        text_area = new JTextArea(3, 20);
        text_area.setLineWrap(true);
        text_area.setWrapStyleWord(true);
        text_area.setBackground(Color.WHITE);
        text_area.setBorder(BorderFactory.createTitledBorder("Text for signature"));
        JScrollPane text_areaScrollPane = new JScrollPane(text_area);
        text_areaScrollPane.setBorder(null);
        add(text_areaScrollPane, BorderLayout.NORTH);

//        JTextField hash_textField = new JTextField(20);
//        hash_textField.setEditable(false);
//        hash_textField.setBackground(Color.WHITE);
//        hash_textField.setBorder(BorderFactory.createTitledBorder("Hash value"));
//        add(hash_textField, BorderLayout.CENTER);

        sign_textField = new JTextArea(3, 20);
        sign_textField.setEditable(false);
        sign_textField.setLineWrap(true);
        sign_textField.setWrapStyleWord(true);
        sign_textField.setBackground(Color.WHITE);
        sign_textField.setBorder(BorderFactory.createTitledBorder("Signature"));
        JScrollPane sign_textFieldScrollPane = new JScrollPane(sign_textField);
        sign_textFieldScrollPane.setBorder(null);
        add(sign_textFieldScrollPane, BorderLayout.SOUTH);
    }
}
