package services;

import dao.UserKeyDAO;

public class UserKeyService {
    UserKeyDAO userKeyDao;
    public UserKeyService() {
        userKeyDao = new UserKeyDAO();
    }


}
