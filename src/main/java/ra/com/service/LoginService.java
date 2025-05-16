package ra.com.service;

import ra.com.model.User;

public interface LoginService {
    boolean checkLogin(String username, String password);
    User findUserByUsername(String username);
}
