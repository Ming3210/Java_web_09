package ra.com.repository;

import ra.com.model.User;

public interface LoginRepository {
    boolean checkLogin(String username, String password);
    User findByUsername(String username);
}
