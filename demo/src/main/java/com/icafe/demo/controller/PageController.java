package com.icafe.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/login")
    public String login() {
        return "login"; // sẽ map tới /WEB-INF/jsp/home.jsp
    }

     @GetMapping("/order")
    public String home() {
        return "order"; // sẽ map tới /WEB-INF/jsp/home.jsp
    }

    @GetMapping("/product")
    public String product() {
        return "product"; // /WEB-INF/jsp/about.jsp
    }

    @GetMapping("/account")
    public String account() {
        return "account"; // /WEB-INF/jsp/contact.jsp
    }

    @GetMapping("/orderpick")
    public String cart() {
        return "orderPick"; // /WEB-INF/jsp/contact.jsp
    }

    @GetMapping("/processing")
    public String processing() {
        return "processing"; // /WEB-INF/jsp/contact.jsp
    }

    @GetMapping("/report")
    public String report() {
        return "report"; // /WEB-INF/jsp/contact.jsp
    }
}
