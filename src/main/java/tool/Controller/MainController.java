package vn.edu.hcmuaf.fit.Controller;

import vn.edu.hcmuaf.fit.Model.DS;
import vn.edu.hcmuaf.fit.View.*;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

public class MainController {
    DS model;
    MainFrame view;
    Integer rsa_keysize;
    String sign_algo;
    PrivateKey privateKey;
    PublicKey publicKey;

    public MainController(DS model, MainFrame view) {
        this.model = model;
        this.view = view;
        addAction();
    }

    public void addAction() {
        //gan gia tri ban dau cho rsa_keysize va sign_slgo
        this.rsa_keysize = (Integer) view.getTopPanel().rsa_keysize_cb.getSelectedItem();
        this.sign_algo = (String) view.getTopPanel().sign_algo_cb.getSelectedItem();
        //top panel - add action combo box
        view.getTopPanel().rsa_keysize_cb.addActionListener(e -> {
            this.rsa_keysize = (Integer) view.getTopPanel().rsa_keysize_cb.getSelectedItem();
            System.out.println(rsa_keysize);
        });
        view.getTopPanel().sign_algo_cb.addActionListener(e -> {
            this.sign_algo = (String) view.getTopPanel().sign_algo_cb.getSelectedItem();
            System.out.println(sign_algo);
        });
        //xoa cac gia tri ben trong priKey & pubKey neu chuyen tu tab 1 sang 2 va nguoc lai
        view.getTopPanel().panel_tabbed.addChangeListener(e -> {
            view.getTopPanel().privateKey.setText("");
            view.getTopPanel().publicKey.setText("");
        });
        //top panel - add action btn
        view.getTopPanel().genKey_btn.addActionListener(e -> {
            try {
                model.genKey(this.rsa_keysize);
                this.publicKey = model.getPublicKey();
                this.privateKey = model.getPrivateKey();
                view.getTopPanel().privateKey.setText(Base64.getEncoder().encodeToString(this.privateKey.getEncoded()));
                view.getTopPanel().publicKey.setText(Base64.getEncoder().encodeToString(this.publicKey.getEncoded()));
            } catch (Exception ex) {
                throw new RuntimeException(ex);
            }
        });
        view.getTopPanel().loadPrivateKey_btn.addActionListener(e -> {
            String path = chooseFilePath(true, false, false);
            if (path != null) {
                try {
                    this.privateKey = model.loadPrivateKey(path);
                    model.setPrivateKey(this.privateKey);
                    view.getTopPanel().privateKey.setText(Base64.getEncoder().encodeToString(this.privateKey.getEncoded()));
                } catch (IllegalArgumentException ex) {
                    JOptionPane.showMessageDialog(null, "File không đúng định dạng Base64.", "Lỗi tải Private Key", JOptionPane.ERROR_MESSAGE);
                } catch (InvalidKeySpecException ex) {
                    JOptionPane.showMessageDialog(view, "Định dạng khóa không hợp lệ (có thể là khóa public hoặc bị hỏng).", "Lỗi tải Private Key", JOptionPane.ERROR_MESSAGE);
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(view, "Lỗi không xác định khi tải Private Key: " + ex.getMessage(), "Lỗi tải Private Key", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        view.getTopPanel().loadPublicKey_btn.addActionListener(e -> {
            String path = chooseFilePath(false, false, false);
            if (path != null) {
                try {
                    this.publicKey = model.loadPublicKey(path);
                    model.setPublicKey(this.publicKey);
                    view.getTopPanel().publicKey.setText(Base64.getEncoder().encodeToString(this.publicKey.getEncoded()));
                } catch (IllegalArgumentException ex) {
                    JOptionPane.showMessageDialog(view, "File không đúng định dạng Base64.", "Lỗi tải Public Key", JOptionPane.ERROR_MESSAGE);
                } catch (InvalidKeySpecException ex) {
                    JOptionPane.showMessageDialog(view, "Định dạng khóa không hợp lệ (có thể là khóa private hoặc bị hỏng).", "Lỗi tải Public Key", JOptionPane.ERROR_MESSAGE);
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(view, "Lỗi không xác định khi tải Public Key: " + ex.getMessage(), "Lỗi tải Public Key", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        view.getTopPanel().savePrivateKey_btn.addActionListener(e -> {
            //kiem tra xem private key da duoc tao de thuc hien hanh dong save hay chua?
            if (privateKey == null) {
                JOptionPane.showMessageDialog(null, "Private Key chưa được tạo để thực hiện lưu!", "Thông báo", JOptionPane.ERROR_MESSAGE);
                return;
            }
            String path = chooseFilePath(true, true, false);
            if (path != null) {
                try {
                    File file = new File(path);
                    //kiem tra path xem, lieu co file cung ten dang ton tai k, q/a: overwrite?
                    if (file.exists()) {
                        int overwrite = JOptionPane.showConfirmDialog(null, "File đã tồn tại. Bạn có muốn ghi đè không?", "Thông báo", JOptionPane.YES_NO_OPTION);
                        if (overwrite != JOptionPane.YES_OPTION) {
                            return;
                        }
                    }
                    //thuc hien hanh dong save private key
                    model.saveKey(path, true);
                } catch (Exception ex) {
                    throw new RuntimeException(ex);
                }
            }
        });
        view.getTopPanel().savePublicKey_btn.addActionListener(e -> {
            if (publicKey == null) {
                JOptionPane.showMessageDialog(null, "Public Key chưa được tạo để thực hiện lưu!", "Thông báo", JOptionPane.ERROR_MESSAGE);
                return;
            }
            String path = chooseFilePath(false, true, false);
            if (path != null) {
                try {
                    File file = new File(path);
                    if (file.exists()) {
                        int overwrite = JOptionPane.showConfirmDialog(null, "File đã tồn tại. Bạn có muốn ghi đè không?", "Thông báo", JOptionPane.YES_NO_OPTION);
                        if (overwrite != JOptionPane.YES_OPTION) {
                            return;
                        }
                    }
                    model.saveKey(path, false);
                } catch (Exception ex) {
                    throw new RuntimeException(ex);
                }
            }
        });
        //bottom panel - sign tab
        view.getBottomPanel().sign_btn.addActionListener(e -> {
            String data = view.getCenterPanel().text_area.getText();
            if (data == null || data.isEmpty()) {
                JOptionPane.showMessageDialog(null, "Dữ liệu thiếu. Bạn chưa nhập vào data cần ký.", "Thông báo", JOptionPane.ERROR_MESSAGE);
                return;
            }
            try {
                if (privateKey == null) {
                    JOptionPane.showMessageDialog(null, "Chương trình chưa nhận được private key để thực hiện ký", "Thông báo", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                String sign = model.sign(data, sign_algo);//base64
                view.getCenterPanel().sign_textField.setText(sign);//sign o dang base64
            } catch (Exception ex) {
                throw new RuntimeException(ex);
            }
        });
        view.getBottomPanel().saveSign_btn.addActionListener(e -> {
            String sign = view.getCenterPanel().sign_textField.getText();
            if (sign.isEmpty() || sign.isBlank()) {
                JOptionPane.showMessageDialog(null, "Chữ ký không chứa dữ liệu hoặc lỗi dữ liệu.", "Lỗi", JOptionPane.ERROR_MESSAGE);
                return;
            }
            String path = chooseFilePath(false, true, true);
            if (path != null) {
                File file = new File(path);
                if (file.exists()) {
                    int overwrite = JOptionPane.showConfirmDialog(null, "File đã tồn tại. Bạn có muốn ghi đè không?", "Thông báo", JOptionPane.YES_NO_OPTION);
                    if (overwrite != JOptionPane.YES_OPTION) {
                        return;
                    }
                }
//                byte[] signBytes = Base64.getDecoder().decode(sign);//giai ma sign lay tu textarea base64 = hashvalue
//                if (signBytes == null || signBytes.length == 0) {
//                    JOptionPane.showMessageDialog(null, "Chữ ký không chứa dữ liệu hoặc lỗi dữ liệu.", "Lỗi", JOptionPane.ERROR_MESSAGE);
//                    return;
//                }
                try {
                    model.saveSign(path, sign);
                } catch (IOException ex) {
                    throw new RuntimeException(ex);
                }
            }
        });
        view.getBottomPanel().copySign_btn.addActionListener(e -> {
            String sign = view.getCenterPanel().sign_textField.getText();
            if (sign == null || sign.isEmpty()) {
                JOptionPane.showMessageDialog(null, "Không có chữ ký để sao chép.", "Thông báo", JOptionPane.WARNING_MESSAGE);
                return;
            }
            StringSelection selection = new StringSelection(sign);
            Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
            clipboard.setContents(selection, null);
            JOptionPane.showMessageDialog(null, "Đã sao chép chữ ký vào clipboard.", "Thông báo", JOptionPane.INFORMATION_MESSAGE);
        });
        //bottom panel - verify tab
        view.getBottomPanel().verify_btn.addActionListener(e -> {
            String data = view.getCenterPanel().text_area.getText();
            String signBase64 = view.getCenterPanel().sign_textField.getText();
            if (data == null || data.isEmpty() || signBase64 == null || signBase64.isEmpty()) {
                JOptionPane.showMessageDialog(null, "Dữ liệu thiếu. Bạn chưa nhập vào data/sign cần xác nhận.", "Thông báo", JOptionPane.ERROR_MESSAGE);
                return;
            }
            try {
                if (publicKey == null) {
                    JOptionPane.showMessageDialog(null, "Chương trình chưa nhận được public key để thực hiện xác nhận", "Thông báo", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                boolean verified = model.verify(data, signBase64, sign_algo);
                if (verified) {
                    JOptionPane.showMessageDialog(null,
                            "Chữ ký hợp lệ! Dữ liệu không bị thay đổi.",
                            "Xác thực thành công", JOptionPane.INFORMATION_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(null,
                            "Chữ ký không hợp lệ! Dữ liệu có thể đã bị thay đổi hoặc khóa sai.",
                            "Xác thực thất bại", JOptionPane.WARNING_MESSAGE);
                }
            } catch (Exception ex) {
                throw new RuntimeException(ex);
            }
        });
        view.getBottomPanel().loadSign_btn.addActionListener(e -> {
            String path = chooseFilePath(false, false, false);
            if (path != null) {
                try {
                    String signBase64 = model.loadFile(path);
                    if (signBase64 == null) {
                        JOptionPane.showMessageDialog(null,
                                "Chữ ký không hợp lệ! Dữ liệu có thể đã bị thay đổi hoặc khóa sai.",
                                "Xác thực thất bại", JOptionPane.WARNING_MESSAGE);
                    }
                    view.getCenterPanel().sign_textField.setText(signBase64);
                } catch (Exception ex) {
                    throw new RuntimeException(ex);
                }
            }
        });
        ActionListener loadFileListener = e -> {
            String path = chooseFilePath(false, false, false);
            System.out.println(path);
            if (path != null) {
                try {
                    String data = model.loadFile(path);
                    if (data.isEmpty()) {
                        JOptionPane.showMessageDialog(null, "Không đọc được dữ liệu từ file!", "Lỗi", JOptionPane.ERROR_MESSAGE);
                        return;
                    }
                    System.out.println(data);
                    view.getCenterPanel().text_area.setText(data);
                } catch (IOException ex) {
                    JOptionPane.showMessageDialog(null, "Đã xảy ra lỗi khi đọc file:\n" + ex.getMessage(), "Lỗi", JOptionPane.ERROR_MESSAGE);
                    ex.printStackTrace();
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(null, "Dữ liệu file không hợp lệ hoặc bị lỗi!", "Lỗi", JOptionPane.ERROR_MESSAGE);
                    ex.printStackTrace();
                }
            }
        };
        view.getBottomPanel().loadFile_sign_btn.addActionListener(loadFileListener);
        view.getBottomPanel().loadFile_verify_btn.addActionListener(loadFileListener);
    }

    private String chooseFilePath(boolean isPrivateKey, boolean isSave, boolean isSign) {
        JFileChooser fileChooser = new JFileChooser();
        FileNameExtensionFilter filter = new FileNameExtensionFilter("TXT file", "txt");
        fileChooser.setFileFilter(filter);
        int selected;
        String fileLabel;
        if (isSign) {
            fileLabel = "sign";
        } else {
            fileLabel = isPrivateKey ? "private" : "public";
        }
        if (isSave) {
            String date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
            String suggestedFileName = fileLabel.toLowerCase() + "_" + date + ".txt";
            fileChooser.setSelectedFile(new File(suggestedFileName));
            selected = fileChooser.showSaveDialog(null);
        } else {
            selected = fileChooser.showOpenDialog(null);
        }

        if (selected == JFileChooser.APPROVE_OPTION) {
            File file = fileChooser.getSelectedFile();
            String path = file.getAbsolutePath();
            if (!path.endsWith(".txt")) {
                path += ".txt";
            }
            return path;
        }
        return null;
    }
}
