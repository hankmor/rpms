package dendy.rpms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/portal")
public class PortalController {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "/portal/login";
    }

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String index() {
        return "/portal/main";
    }

    @RequestMapping(value = "/welcome", method = RequestMethod.POST)
    public String welcome() {
        return "/portal/welcome";
    }
}
