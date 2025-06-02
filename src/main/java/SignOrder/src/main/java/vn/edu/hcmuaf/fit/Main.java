package vn.edu.hcmuaf.fit;

import vn.edu.hcmuaf.fit.Controller.MainController;
import vn.edu.hcmuaf.fit.Model.DS;
import vn.edu.hcmuaf.fit.View.MainFrame;

public class Main {
    public static void main(String[] args) {
        DS model = new DS();
        MainFrame view = new MainFrame();
        MainController controller = new MainController(model, view);
    }
}