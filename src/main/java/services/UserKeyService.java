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

    public UserKeys getUserKeyById(int keyId) {
        return userKeyDao.getUserKeysById(keyId);
    }

    public boolean insertUserKey(int userId, String keyValue) {
        try {
            boolean inserted = userKeyDao.insertUserKeys(userId, keyValue);
            if (!inserted) {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public boolean updateUserKey(int userId, String keyValue) {
        try {
            boolean updated = userKeyDao.updateUserKeys(userId, keyValue);
            if (!updated) {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
        return true;
    }


}
