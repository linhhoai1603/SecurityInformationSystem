package services;

import dao.UserDao;
import dao.UserKeyDAO;
import models.UserKeys;

public class UserKeyService {
    UserKeyDAO userKeyDao;
    UserDao userDao;
    public UserKeyService() {
        userKeyDao = new UserKeyDAO();
        userDao = new UserDao();
    }

//    public UserKeys getCurrentUserKey(int userId) {
//        return userKeyDao.getCurrentUserKey(userId);
//    }

    public boolean saveOrUpdateUserKey(int userId, String keyValue) {
        if(userKeyDao.userKeyExist(userId))
        {
            return userKeyDao.updateUserKey(userId, keyValue);
        }
        else{
            return userKeyDao.insertUserKey(userId, keyValue);
        }
    }
}
