package ra.com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ra.com.model.User;
import ra.com.service.LoginService;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               HttpSession session,
                               Model model) {

        boolean loginSuccess = loginService.checkLogin(username, password);
        User user = loginService.findUserByUsername(username);


        if (loginSuccess) {
            session.setAttribute("username", username);
            session.setAttribute("user", user);
            session.setAttribute("isLoggedIn", true);

            return "redirect:/home";
        } else {
            model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}