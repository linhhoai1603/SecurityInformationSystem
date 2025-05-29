package services;

import dao.UserKeyDAO;
import models.UserKeys;

public class UserKeyService {
    UserKeyDAO userKeyDao;
    public UserKeyService() {
        userKeyDao = new UserKeyDAO();
    }

    public UserKeys getCurrentUserKey(int userId) {
        return userKeyDao.getCurrentUserKey(userId);
    }


}
