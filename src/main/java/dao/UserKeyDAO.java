package dao;

import connection.DBConnection;
import org.jdbi.v3.core.Jdbi;

public class UserKeyDAO {
    Jdbi jdbi;
    public UserKeyDAO() {
        this.jdbi = DBConnection.getConnetion();
    }
}
