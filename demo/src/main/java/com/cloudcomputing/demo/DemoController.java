package com.cloudcomputing.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    // Injecting a configuration property
    @Value("${spring.application.name}")
    private String appName;

    @GetMapping("/api/hello")
    public String getData() {
        return "Hello From:" + appName;
    }
}
