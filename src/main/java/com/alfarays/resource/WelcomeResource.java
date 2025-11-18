package com.alfarays.resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WelcomeResource {

    @GetMapping
    public String index() {
        return "index";
    }

}
