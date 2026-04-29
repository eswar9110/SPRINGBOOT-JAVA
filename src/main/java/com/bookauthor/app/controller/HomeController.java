package com.bookauthor.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Home controller to handle the root URL.
 * Redirects to the authors list page as the landing page.
 */
@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "redirect:/authors";
    }
}
