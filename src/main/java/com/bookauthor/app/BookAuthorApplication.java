package com.bookauthor.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/**
 * Main Spring Boot Application class.
 * Extends SpringBootServletInitializer for WAR deployment with JSP support.
 */
@SpringBootApplication
public class BookAuthorApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(BookAuthorApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(BookAuthorApplication.class, args);
    }
}
