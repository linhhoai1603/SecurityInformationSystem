package dao;

import connection.DBConnection;
import models.Address;
import models.Price;
import models.User;
import org.jdbi.v3.core.Jdbi;

public class PriceDAO {
    Jdbi jdbi;
    public PriceDAO(){
        jdbi = DBConnection.getConnetion();
    }
    public int addPrice(Price price) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO prices (price, discountPercent) " +
                                "VALUES (?, ?)")
                        .bind(0, price.getPrice())
                        .bind(1,price.getDiscountPercent())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one());
    }

    public Price getPriceById(int idPrice) {
        String sql = "SELECT * FROM prices WHERE id = :idPrice";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind("idPrice", idPrice)
                    .map((rs, ctx) ->{
                        Price price = new Price();

                        price.setId(rs.getInt("id"));
                        price.setPrice(rs.getDouble("price"));
                        price.setDiscountPercent(rs.getFloat("discountPercent"));
                        price.setLastPrice(rs.getDouble("lastPrice"));

                        return price;
                    }).findOne().orElse(null);
        });
    }

    public static void main(String[] args) {
        PriceDAO priceDAO = new PriceDAO();
        System.out.println(priceDAO.getPriceById(1).toString());
    }
}
