package vn.edu.hcmuaf.fit.View;

import javax.swing.*;
import java.awt.*;

public class MainFrame extends JFrame {
    private TopPanel topPanel;
    private CenterPanel centerPanel;
    private BottomPanel bottomPanel;

    public MainFrame() {
        setTitle("Digital Signature");
        setBounds(100, 100, 450, 300);

        topPanel = new TopPanel();
        add(topPanel, BorderLayout.NORTH);

        centerPanel = new CenterPanel();
        add(centerPanel, BorderLayout.CENTER);

        bottomPanel = new BottomPanel();
        add(bottomPanel, BorderLayout.SOUTH);
//        setSize(800, 600);
        pack();
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
        setLocationRelativeTo(null);
    }

    public TopPanel getTopPanel() {
        return topPanel;
    }

    public void setTopPanel(TopPanel topPanel) {
        this.topPanel = topPanel;
    }

    public CenterPanel getCenterPanel() {
        return centerPanel;
    }

    public void setCenterPanel(CenterPanel centerPanel) {
        this.centerPanel = centerPanel;
    }

    public BottomPanel getBottomPanel() {
        return bottomPanel;
    }

    public void setBottomPanel(BottomPanel bottomPanel) {
        this.bottomPanel = bottomPanel;
    }

}
