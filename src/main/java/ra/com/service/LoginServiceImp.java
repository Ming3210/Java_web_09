package ra.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ra.com.model.User;
import ra.com.repository.LoginRepository;

@Service
public class LoginServiceImp implements LoginService{

    @Autowired
    private LoginRepository loginRepository;
    @Override
    public boolean checkLogin(String username, String password) {
        return loginRepository.checkLogin(username,password);
    }

    @Override
    public User findUserByUsername(String username) {
        return loginRepository.findByUsername(username);
    }
}
