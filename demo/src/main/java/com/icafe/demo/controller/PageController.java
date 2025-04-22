package com.icafe.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/login")
    public String login() {
        return "login";
    }

     @GetMapping("/order")
    public String home() {
        return "order"; 
    }

    @GetMapping("/product")
    public String product() {
        return "product"; 
    }

    @GetMapping("/account")
    public String account() {
        return "account"; 
    }

    @GetMapping("/orderpick")
    public String cart() {
        return "orderPick";
    }

    @GetMapping("/processing")
    public String processing() {
        return "processing";
    }

    @GetMapping("/report")
    public String report() {
        return "report"; 
    }

    @GetMapping("/category")
    public String category() {
        return "category"; 
    }
}
