package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/test")
public class Controller {
    @GetMapping("/hello")
    public String getMessage(){
        return "Hello World";
    }
}
