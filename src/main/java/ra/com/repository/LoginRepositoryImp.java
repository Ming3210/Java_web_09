package ra.com.repository;

import org.springframework.stereotype.Repository;
import ra.com.utils.ConnectionDB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
@Repository
public class LoginRepositoryImp implements LoginRepository{
    @Override
    public boolean checkLogin(String username, String password) {
        Connection conn = null;
        CallableStatement callableStatement = null;
        ResultSet resultSet = null;

        try {
            conn = new ConnectionDB().openConnection();
            String sql = "{call login(?,?)}";
            callableStatement = conn.prepareCall(sql);
            callableStatement.setString(1, username);
            callableStatement.setString(2, password);

            resultSet = callableStatement.executeQuery();

            if (resultSet.next()) {
                return true;
            }
            return false;

        } catch (SQLException e) {
            System.err.println("Lỗi đăng nhập: " + e.getMessage());
            if (e.getSQLState().equals("45000")) {
                System.err.println("Tên đăng nhập hoặc mật khẩu không đúng!");
            }
            return false;
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            ConnectionDB.closeConnection(conn, callableStatement);
        }
    }
}
